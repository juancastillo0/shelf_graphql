import 'dart:async';
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show HttpServer;

import 'package:http/http.dart' as http;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_router/shelf_router.dart' show Router;

Future<void> main() async {
  final server = await runServer();
  final url = Uri.parse('http://${server.address.host}:${server.port}/graphql');
  await testServer(url);
}

/// Set up your state.
/// This could be anything such as a database connection
final stateRef = RefWithDefault<ModelController>.global(
  (scope) => ModelController(
    Model('InitialState', DateTime.now()),
  ),
);

class ModelController {
  Model? _value;
  Model? get value => _value;

  final _streamController = StreamController<Model>.broadcast();
  Stream<Model> get stream => _streamController.stream;

  ModelController(this._value);

  void setValue(Model newValue) {
    if (newValue.state == 'InvalidState') {
      // This will appear as an GraphQLError in the response.
      // You can pass more information using custom extensions.
      throw GraphQLError(
        "Can't be in InvalidState.",
        extensions: {'errorCodeExtension': 'INVALID_STATE'},
      );
    }
    _value = newValue;
    _streamController.add(newValue);
  }
}

@GraphQLClass()
class Model {
  final String state;
  final DateTime createdAt;

  const Model(this.state, this.createdAt);
}

/// Create a [GraphQLSchema]
GraphQLSchema makeGraphQLSchema() {
  final GraphQLObjectType<Model> modelGraphqlType = objectType<Model>(
    'Model',
    fields: [
      graphQLString.nonNull().field(
            'state',
            resolve: (Model model, ReqCtx ctx) => model.state,
          ),
      graphQLDate.nonNull().field(
            'createdAt',
            resolve: (Model model, ReqCtx ctx) => model.createdAt,
          ),
    ],
  );

  const schemaString = '''
type Query {
  """Get the current state"""
  getState: Model
}

type Model {
  state: String!
  createdAt: Date!
}

"""An ISO-8601 Date."""
scalar Date

type Mutation {
  setState(
    """The new state, can't be 'WrongState'!."""
    newState: String!
  ): Boolean!
}

type Subscription {
  onStateChange: Model!
}''';
  final schema = GraphQLSchema(
    queryType: objectType('Query', fields: [
      modelGraphqlType.field(
        'getState',
        description: 'Get the current state',
        resolve: (Object rootValue, ReqCtx ctx) => stateRef.get(ctx).value,
      ),
    ]),
    mutationType: objectType('Mutation', fields: [
      graphQLBoolean.nonNull().field(
        'setState',
        // TODO: arguments instead of inputs
        arguments: [
          GraphQLFieldInput(
            'newState',
            graphQLString.nonNull(),
            description: "The new state, can't be 'WrongState'!.",
          ),
        ],
        resolve: (Object rootValue, ReqCtx ctx) {
          final newState = ctx.args['newState']! as String;
          if (newState == 'WrongState') {
            return false;
          }
          stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
          return true;
        },
      ),
    ]),
    subscriptionType: objectType('Subscription', fields: [
      modelGraphqlType.nonNull().field(
            'onStateChange',
            subscribe: (Object rootValue, ReqCtx ctx) =>
                stateRef.get(ctx).stream,
          )
    ]),
  );
  assert(schema.schemaStr == schemaString);
  return schema;
}

Future<HttpServer> runServer({int? serverPort, ScopedMap? globals}) async {
  // you can override state with ScopedMap.setGlobal/setScoped
  final ScopedMap scopedMap = globals ?? ScopedMap.empty();
  if (globals == null) {
    // if it wasn't overriten it should be the default
    assert(stateRef.get(scopedMap).value?.state == 'InitialState');
  }
  // Instantiate the GraphQLSchema
  final schema = makeGraphQLSchema();
  // Instantiate the GraphQL executor, you can pass extensions and
  // decide whether you want to intronspect the schema
  // and validate the requests
  final letoGraphQL = GraphQL(
    schema,
    extensions: [],
    introspect: true,
  );

  final port =
      serverPort ?? const int.fromEnvironment('PORT', defaultValue: 8080);
  const graphqlPath = 'graphql';
  const graphqlSubscriptionPath = 'graphql-subscription';
  final endpoint = 'http://localhost:$port/$graphqlPath';
  final subscriptionEndpoint = 'ws://localhost:$port/$graphqlSubscriptionPath';

  // Setup server endpoints
  final app = Router();
  // Main GraphQL HTTP handler
  app.all(
    '/$graphqlPath',
    graphqlHttp(letoGraphQL, globalVariables: scopedMap),
  );
  // Main GraphQL WebSocket handler
  app.all(
    '/$graphqlSubscriptionPath',
    graphqlWebSocket(
      letoGraphQL,
      globalVariables: scopedMap,
      pingInterval: const Duration(seconds: 10),
      validateIncomingConnection: (
        Map<String, Object?>? initialPayload,
        GraphQLWebSocketServer wsServer,
      ) {
        if (initialPayload != null) {
          // you can authenticated an user with the initialPayload:
          // final token = initialPayload['token']! as String;
          // ...
        }
        return true;
      },
    ),
  );
  // GraphQL schema and endpoint explorer web UI.
  // Available UI handlers: playgroundHandler, graphiqlHandler and altairHandler
  app.get(
    '/playground',
    playgroundHandler(
      config: PlaygroundConfig(
        endpoint: endpoint,
        subscriptionEndpoint: subscriptionEndpoint,
      ),
    ),
  );
  // Simple endpoint to download the GraphQLSchema as a SDL file.
  // $ curl http://localhost:8080/graphql-schema > schema.graphql
  const downloadSchemaOnOpen = true;
  const schemaFilename = 'schema.graphql';
  app.get('/graphql-schema', (Request request) {
    return Response.ok(
      schema.schemaStr,
      headers: {
        'content-type': 'text/plain',
        'content-disposition': downloadSchemaOnOpen
            ? 'attachment; filename="$schemaFilename"'
            : 'inline',
      },
    );
  });

  // Set up other shelf handlers such as static files

  // Start the server
  final server = await shelf_io.serve(
    const Pipeline()
        // Configure middlewares
        .addMiddleware(customLog(log: (msg) {
          // TODO:
          if (!msg.contains('IntrospectionQuery')) {
            print(msg);
          }
        }))
        .addMiddleware(cors())
        .addMiddleware(etag())
        .addHandler(app),
    '0.0.0.0',
    port,
  );
  print(
    'Serving GraphQL at $endpoint\n'
    'GraphQL Playground UI at http://localhost:$port/playground',
  );

  return server;
}

/// For a complete GraphQL client you probably want to use
/// Ferry (https://github.com/gql-dart/ferry)
/// Artemis (https://github.com/comigor/artemis)
/// or raw GQL Links (https://github.com/gql-dart/gql/tree/master/links)
Future<void> testServer(Uri url) async {
  final before = DateTime.now();
  const newState = 'NewState';
  // POST request which sets the state
  final response = await http.post(
    url,
    body: jsonEncode({
      'query':
          r'mutation setState ($state: String!) { setState(newState: $state) }',
      'variables': {'state': newState}
    }),
    headers: {'content-type': 'application/json'},
  );
  assert(response.statusCode == 200);
  final body = jsonDecode(response.body) as Map<String, Object?>;
  final data = body['data']! as Map<String, Object?>;
  assert(data['setState'] == true);

  // Also works with GET
  final responseGet = await http.get(url.replace(
    queryParameters: <String, String>{
      'query': '{ getState { state createdAt } }'
    },
  ));
  assert(responseGet.statusCode == 200);
  final bodyGet = jsonDecode(responseGet.body) as Map<String, Object?>;
  final dataGet = bodyGet['data']! as Map<String, dynamic>;
  assert(dataGet['getState']['state'] == newState);
  final createdAt = DateTime.parse(dataGet['getState']['createdAt'] as String);
  assert(createdAt.isAfter(before));
  assert(createdAt.isBefore(DateTime.now()));

  // To test subscriptions you can open the playground web UI at /playground
  // or programatically using https://github.com/gql-dart/gql/tree/master/links/gql_websocket_link,
  // an example can be found in test/mutation_and_subscription_test.dart
}

/// Code Generation
/// Using leto_generator, [makeGraphQLSchema] could be generated
/// with the following annotated functions and the [GraphQLClass]
/// annotation over [Model]

/// Get the current state
@Query()
Model? getState(ReqCtx ctx) {
  return stateRef.get(ctx).value;
}

@Mutation()
bool setState(
  ReqCtx ctx,
  // The new state, can't be 'WrongState'!.
  String newState,
) {
  if (newState == 'WrongState') {
    return false;
  }

  stateRef.get(ctx).setValue(Model(newState, DateTime.now()));
  return true;
}

@Subscription()
Stream<Model> onStateChange(ReqCtx ctx) {
  return stateRef.get(ctx).stream;
}
