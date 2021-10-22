// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_event.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<DBEvent, Object, Object> onEventGraphQLField = field(
  'onEvent',
  dBEventGraphQlType.nonNull() as GraphQLType<DBEvent, Object>,
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onEvent(ctx);
  },
  deprecationReason: null,
);

final GraphQLObjectField<DBEvent, Object, Object> onMessageEventGraphQLField =
    field(
  'onMessageEvent',
  dBEventGraphQlType.nonNull() as GraphQLType<DBEvent, Object>,
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageEvent(ctx);
  },
  deprecationReason: null,
);

final GraphQLObjectField<Paginated<DBEvent>, Object, Object>
    getEventsGraphQLField = field(
  'getEvents',
  paginatedGraphQlType(dBEventGraphQlType.nonNull()).nonNull()
      as GraphQLType<Paginated<DBEvent>, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getEvents(ctx, (args["cursor"] as String?), (args["delta"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "cursor",
      graphQLString.coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "delta",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatDBEventDataSerializer = SerializerValue<ChatDBEventData>(
  fromJson: _$$ChatDBEventDataFromJson,
  toJson: (m) => _$$ChatDBEventDataToJson(m as _$ChatDBEventData),
);
GraphQLObjectType<ChatDBEventData>? _chatDBEventDataGraphQlType;

/// Auto-generated from [ChatDBEventData].
GraphQLObjectType<ChatDBEventData> get chatDBEventDataGraphQlType {
  final __name = 'ChatDBEventData';
  if (_chatDBEventDataGraphQlType != null)
    return _chatDBEventDataGraphQlType! as GraphQLObjectType<ChatDBEventData>;

  final __chatDBEventDataGraphQlType = objectType<ChatDBEventData>(
      'ChatDBEventData',
      isInterface: false,
      interfaces: [],
      description: null);
  _chatDBEventDataGraphQlType = __chatDBEventDataGraphQlType;
  __chatDBEventDataGraphQlType.fields.addAll(
    [
      field('value', chatEventGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null),
      dBEventDataGraphQlTypeDiscriminant()
    ],
  );

  return __chatDBEventDataGraphQlType;
}

final userChatDBEventDataSerializer = SerializerValue<UserChatDBEventData>(
  fromJson: _$$UserChatDBEventDataFromJson,
  toJson: (m) => _$$UserChatDBEventDataToJson(m as _$UserChatDBEventData),
);
GraphQLObjectType<UserChatDBEventData>? _userChatDBEventDataGraphQlType;

/// Auto-generated from [UserChatDBEventData].
GraphQLObjectType<UserChatDBEventData> get userChatDBEventDataGraphQlType {
  final __name = 'UserChatDBEventData';
  if (_userChatDBEventDataGraphQlType != null)
    return _userChatDBEventDataGraphQlType!
        as GraphQLObjectType<UserChatDBEventData>;

  final __userChatDBEventDataGraphQlType = objectType<UserChatDBEventData>(
      'UserChatDBEventData',
      isInterface: false,
      interfaces: [],
      description: null);
  _userChatDBEventDataGraphQlType = __userChatDBEventDataGraphQlType;
  __userChatDBEventDataGraphQlType.fields.addAll(
    [
      field('value', userChatEventGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null),
      dBEventDataGraphQlTypeDiscriminant()
    ],
  );

  return __userChatDBEventDataGraphQlType;
}

final userDBEventDataSerializer = SerializerValue<UserDBEventData>(
  fromJson: _$$UserDBEventDataFromJson,
  toJson: (m) => _$$UserDBEventDataToJson(m as _$UserDBEventData),
);
GraphQLObjectType<UserDBEventData>? _userDBEventDataGraphQlType;

/// Auto-generated from [UserDBEventData].
GraphQLObjectType<UserDBEventData> get userDBEventDataGraphQlType {
  final __name = 'UserDBEventData';
  if (_userDBEventDataGraphQlType != null)
    return _userDBEventDataGraphQlType! as GraphQLObjectType<UserDBEventData>;

  final __userDBEventDataGraphQlType = objectType<UserDBEventData>(
      'UserDBEventData',
      isInterface: false,
      interfaces: [],
      description: null);
  _userDBEventDataGraphQlType = __userDBEventDataGraphQlType;
  __userDBEventDataGraphQlType.fields.addAll(
    [
      field('value', userEventGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null),
      dBEventDataGraphQlTypeDiscriminant()
    ],
  );

  return __userDBEventDataGraphQlType;
}

final chatMessageDBEventDataSerializer =
    SerializerValue<ChatMessageDBEventData>(
  fromJson: _$$ChatMessageDBEventDataFromJson,
  toJson: (m) => _$$ChatMessageDBEventDataToJson(m as _$ChatMessageDBEventData),
);
GraphQLObjectType<ChatMessageDBEventData>? _chatMessageDBEventDataGraphQlType;

/// Auto-generated from [ChatMessageDBEventData].
GraphQLObjectType<ChatMessageDBEventData>
    get chatMessageDBEventDataGraphQlType {
  final __name = 'ChatMessageDBEventData';
  if (_chatMessageDBEventDataGraphQlType != null)
    return _chatMessageDBEventDataGraphQlType!
        as GraphQLObjectType<ChatMessageDBEventData>;

  final __chatMessageDBEventDataGraphQlType =
      objectType<ChatMessageDBEventData>('ChatMessageDBEventData',
          isInterface: false, interfaces: [], description: null);
  _chatMessageDBEventDataGraphQlType = __chatMessageDBEventDataGraphQlType;
  __chatMessageDBEventDataGraphQlType.fields.addAll(
    [
      field('value', chatMessageEventGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.value,
          inputs: [],
          description: null,
          deprecationReason: null),
      dBEventDataGraphQlTypeDiscriminant()
    ],
  );

  return __chatMessageDBEventDataGraphQlType;
}

final dBEventDataSerializer = SerializerValue<DBEventData>(
  fromJson: _$DBEventDataFromJson,
  toJson: (m) => _$DBEventDataToJson(m as DBEventData),
);

Map<String, Object?> _$DBEventDataToJson(DBEventData instance) =>
    instance.toJson();

GraphQLObjectField<String, String, P>
    dBEventDataGraphQlTypeDiscriminant<P extends DBEventData>() => field(
          'runtimeType',
          enumTypeFromStrings(
              'DBEventDataType', ["chat", "userChat", "user", "message"]),
        );

GraphQLUnionType<DBEventData>? _dBEventDataGraphQlType;
GraphQLUnionType<DBEventData> get dBEventDataGraphQlType {
  return _dBEventDataGraphQlType ??= GraphQLUnionType(
    'DBEventData',
    [
      chatDBEventDataGraphQlType,
      userChatDBEventDataGraphQlType,
      userDBEventDataGraphQlType,
      chatMessageDBEventDataGraphQlType
    ],
  );
}

final dBEventSerializer = SerializerValue<DBEvent>(
  fromJson: _$DBEventFromJson,
  toJson: (m) => _$DBEventToJson(m as DBEvent),
);
GraphQLObjectType<DBEvent>? _dBEventGraphQlType;

/// Auto-generated from [DBEvent].
GraphQLObjectType<DBEvent> get dBEventGraphQlType {
  final __name = 'DBEvent';
  if (_dBEventGraphQlType != null)
    return _dBEventGraphQlType! as GraphQLObjectType<DBEvent>;

  final __dBEventGraphQlType = objectType<DBEvent>('DBEvent',
      isInterface: false, interfaces: [], description: null);
  _dBEventGraphQlType = __dBEventGraphQlType;
  __dBEventGraphQlType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('sessionId', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.sessionId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('type', eventTypeGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.type,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('data', dBEventDataGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.data,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __dBEventGraphQlType;
}

Map<String, GraphQLObjectType<Paginated>> _paginatedGraphQlType = {};

/// Auto-generated from [Paginated].
GraphQLObjectType<Paginated<T>> paginatedGraphQlType<T extends Object>(
  GraphQLType<T, Object> tGraphQlType,
) {
  final __name =
      'Paginated${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}';
  if (_paginatedGraphQlType[__name] != null)
    return _paginatedGraphQlType[__name]! as GraphQLObjectType<Paginated<T>>;

  final __paginatedGraphQlType = objectType<Paginated<T>>(
      'Paginated${tGraphQlType is GraphQLTypeWrapper ? (tGraphQlType as GraphQLTypeWrapper).ofType : tGraphQlType}',
      isInterface: false,
      interfaces: [],
      description: null);
  _paginatedGraphQlType[__name] = __paginatedGraphQlType;
  __paginatedGraphQlType.fields.addAll(
    [
      field('values', listOf(tGraphQlType.nonNull()).nonNull(),
          resolve: (obj, ctx) => obj.values,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('pageInfo', pageInfoGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.pageInfo,
          inputs: [],
          description: null,
          deprecationReason: null)
    ],
  );

  return __paginatedGraphQlType;
}

/// Auto-generated from [EventType].
final GraphQLEnumType<EventType> eventTypeGraphQlType =
    enumType('EventType', const {
  'chatCreated': EventType.chatCreated,
  'chatDeleted': EventType.chatDeleted,
  'userChatRemoved': EventType.userChatRemoved,
  'userChatAdded': EventType.userChatAdded,
  'userCreated': EventType.userCreated,
  'userSessionSignedUp': EventType.userSessionSignedUp,
  'userSessionSignedIn': EventType.userSessionSignedIn,
  'userSessionSignedOut': EventType.userSessionSignedOut,
  'messageSent': EventType.messageSent,
  'messageDeleted': EventType.messageDeleted,
  'messageUpdated': EventType.messageUpdated
});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DBEvent _$DBEventFromJson(Map<String, dynamic> json) => DBEvent(
      id: json['id'] as int,
      userId: json['userId'] as int,
      sessionId: json['sessionId'] as String,
      type: _$enumDecode(_$EventTypeEnumMap, json['type']),
      data: DBEventData.fromJson(json['data'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DBEventToJson(DBEvent instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'sessionId': instance.sessionId,
      'type': _$EventTypeEnumMap[instance.type],
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$EventTypeEnumMap = {
  EventType.chatCreated: 'chatCreated',
  EventType.chatDeleted: 'chatDeleted',
  EventType.userChatRemoved: 'userChatRemoved',
  EventType.userChatAdded: 'userChatAdded',
  EventType.userCreated: 'userCreated',
  EventType.userSessionSignedUp: 'userSessionSignedUp',
  EventType.userSessionSignedIn: 'userSessionSignedIn',
  EventType.userSessionSignedOut: 'userSessionSignedOut',
  EventType.messageSent: 'messageSent',
  EventType.messageDeleted: 'messageDeleted',
  EventType.messageUpdated: 'messageUpdated',
};

_$ChatDBEventData _$$ChatDBEventDataFromJson(Map<String, dynamic> json) =>
    _$ChatDBEventData(
      ChatEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatDBEventDataToJson(_$ChatDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$UserChatDBEventData _$$UserChatDBEventDataFromJson(
        Map<String, dynamic> json) =>
    _$UserChatDBEventData(
      UserChatEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChatDBEventDataToJson(
        _$UserChatDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$UserDBEventData _$$UserDBEventDataFromJson(Map<String, dynamic> json) =>
    _$UserDBEventData(
      UserEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserDBEventDataToJson(_$UserDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$ChatMessageDBEventData _$$ChatMessageDBEventDataFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageDBEventData(
      ChatMessageEvent.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageDBEventDataToJson(
        _$ChatMessageDBEventData instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
