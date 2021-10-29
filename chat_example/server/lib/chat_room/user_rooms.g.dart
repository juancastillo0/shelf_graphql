// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rooms.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatRoomUser, Object, Object>
    addChatRoomUserGraphQLField = field(
  'addChatRoomUser',
  chatRoomUserGraphQLType as GraphQLType<ChatRoomUser, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return addChatRoomUser(
        ctx, (args["chatId"] as int), (args["userId"] as int),
        role: (args["role"] as ChatRoomUserRole));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "userId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "role",
      chatRoomUserRoleGraphQLType.nonNull().coerceToInputObject(),
      defaultValue: ChatRoomUserRole.peer,
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<bool, Object, Object> deleteChatRoomUserGraphQLField =
    field(
  'deleteChatRoomUser',
  graphQLBoolean.nonNull() as GraphQLType<bool, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return deleteChatRoomUser(
        ctx, (args["chatId"] as int), (args["userId"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "userId",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final userChatAddedEventSerializer = SerializerValue<UserChatAddedEvent>(
  fromJson: (ctx, json) =>
      UserChatAddedEvent.fromJson(json), // _$$UserChatAddedEventFromJson,
  // toJson: (m) => _$$UserChatAddedEventToJson(m as _$UserChatAddedEvent),
);

GraphQLObjectType<UserChatAddedEvent>? _userChatAddedEventGraphQLType;

/// Auto-generated from [UserChatAddedEvent].
GraphQLObjectType<UserChatAddedEvent> get userChatAddedEventGraphQLType {
  final __name = 'UserChatAddedEvent';
  if (_userChatAddedEventGraphQLType != null)
    return _userChatAddedEventGraphQLType!
        as GraphQLObjectType<UserChatAddedEvent>;

  final __userChatAddedEventGraphQLType = objectType<UserChatAddedEvent>(
      'UserChatAddedEvent',
      isInterface: false,
      interfaces: []);

  _userChatAddedEventGraphQLType = __userChatAddedEventGraphQLType;
  __userChatAddedEventGraphQLType.fields.addAll(
    [
      field('chatUser', chatRoomUserGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.chatUser),
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      userChatEventGraphQLTypeDiscriminant()
    ],
  );

  return __userChatAddedEventGraphQLType;
}

final userChatRemovedEventSerializer = SerializerValue<UserChatRemovedEvent>(
  fromJson: (ctx, json) =>
      UserChatRemovedEvent.fromJson(json), // _$$UserChatRemovedEventFromJson,
  // toJson: (m) => _$$UserChatRemovedEventToJson(m as _$UserChatRemovedEvent),
);

GraphQLObjectType<UserChatRemovedEvent>? _userChatRemovedEventGraphQLType;

/// Auto-generated from [UserChatRemovedEvent].
GraphQLObjectType<UserChatRemovedEvent> get userChatRemovedEventGraphQLType {
  final __name = 'UserChatRemovedEvent';
  if (_userChatRemovedEventGraphQLType != null)
    return _userChatRemovedEventGraphQLType!
        as GraphQLObjectType<UserChatRemovedEvent>;

  final __userChatRemovedEventGraphQLType = objectType<UserChatRemovedEvent>(
      'UserChatRemovedEvent',
      isInterface: false,
      interfaces: []);

  _userChatRemovedEventGraphQLType = __userChatRemovedEventGraphQLType;
  __userChatRemovedEventGraphQLType.fields.addAll(
    [
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      userChatEventGraphQLTypeDiscriminant()
    ],
  );

  return __userChatRemovedEventGraphQLType;
}

final userChatEventSerializer = SerializerValue<UserChatEvent>(
  fromJson: (ctx, json) =>
      UserChatEvent.fromJson(json), // _$UserChatEventFromJson,
  // toJson: (m) => _$UserChatEventToJson(m as UserChatEvent),
);

// Map<String, Object?> _$UserChatEventToJson(UserChatEvent instance) => instance.toJson();

GraphQLObjectField<String, String, P>
    userChatEventGraphQLTypeDiscriminant<P extends UserChatEvent>() => field(
          'runtimeType',
          enumTypeFromStrings('UserChatEventType', ["added", "removed"]),
        );

GraphQLUnionType<UserChatEvent>? _userChatEventGraphQLType;
GraphQLUnionType<UserChatEvent> get userChatEventGraphQLType {
  return _userChatEventGraphQLType ??= GraphQLUnionType(
    'UserChatEvent',
    [userChatAddedEventGraphQLType, userChatRemovedEventGraphQLType],
  );
}

final chatRoomUserSerializer = SerializerValue<ChatRoomUser>(
  fromJson: (ctx, json) =>
      ChatRoomUser.fromJson(json), // _$ChatRoomUserFromJson,
  // toJson: (m) => _$ChatRoomUserToJson(m as ChatRoomUser),
);

GraphQLObjectType<ChatRoomUser>? _chatRoomUserGraphQLType;

/// Auto-generated from [ChatRoomUser].
GraphQLObjectType<ChatRoomUser> get chatRoomUserGraphQLType {
  final __name = 'ChatRoomUser';
  if (_chatRoomUserGraphQLType != null)
    return _chatRoomUserGraphQLType! as GraphQLObjectType<ChatRoomUser>;

  final __chatRoomUserGraphQLType = objectType<ChatRoomUser>('ChatRoomUser',
      isInterface: false, interfaces: []);

  _chatRoomUserGraphQLType = __chatRoomUserGraphQLType;
  __chatRoomUserGraphQLType.fields.addAll(
    [
      field('user', userGraphQLType.nonNull(), resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.user(ctx);
      }),
      field('userId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.userId),
      field('chatId', graphQLInt.nonNull(), resolve: (obj, ctx) => obj.chatId),
      field('role', chatRoomUserRoleGraphQLType.nonNull(),
          resolve: (obj, ctx) => obj.role),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt)
    ],
  );

  return __chatRoomUserGraphQLType;
}

/// Auto-generated from [ChatRoomUserRole].
final GraphQLEnumType<ChatRoomUserRole> chatRoomUserRoleGraphQLType = enumType(
    'ChatRoomUserRole',
    const {'admin': ChatRoomUserRole.admin, 'peer': ChatRoomUserRole.peer});

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomUser _$ChatRoomUserFromJson(Map<String, dynamic> json) => ChatRoomUser(
      userId: json['userId'] as int,
      chatId: json['chatId'] as int,
      role: _$enumDecode(_$ChatRoomUserRoleEnumMap, json['role']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ChatRoomUserToJson(ChatRoomUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'chatId': instance.chatId,
      'role': _$ChatRoomUserRoleEnumMap[instance.role],
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

const _$ChatRoomUserRoleEnumMap = {
  ChatRoomUserRole.admin: 'admin',
  ChatRoomUserRole.peer: 'peer',
};

_$UserChatAddedEvent _$$UserChatAddedEventFromJson(Map<String, dynamic> json) =>
    _$UserChatAddedEvent(
      chatUser: ChatRoomUser.fromJson(json['chatUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChatAddedEventToJson(
        _$UserChatAddedEvent instance) =>
    <String, dynamic>{
      'chatUser': instance.chatUser,
    };

_$UserChatRemovedEvent _$$UserChatRemovedEventFromJson(
        Map<String, dynamic> json) =>
    _$UserChatRemovedEvent(
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$$UserChatRemovedEventToJson(
        _$UserChatRemovedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
    };
