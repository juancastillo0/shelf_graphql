// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_table.dart';

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final GraphQLObjectField<ChatMessage, Object, Object> sendMessageGraphQLField =
    field(
  'sendMessage',
  chatMessageGraphQlType as GraphQLType<ChatMessage, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendMessage(ctx, (args["chatId"] as int),
        (args["message"] as String), (args["referencedMessageId"] as int?));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "message",
      graphQLString.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "referencedMessageId",
      graphQLInt.coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<ChatMessage, Object, Object>
    sendFileMessageGraphQLField = field(
  'sendFileMessage',
  chatMessageGraphQlType as GraphQLType<ChatMessage, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return sendFileMessage(ctx, (args["chatId"] as int),
        (args["file"] as UploadedFile), (args["referencedMessageId"] as int?));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "file",
      uploadedFileGraphQlType.nonNull().coerceToInputObject(),
    ),
    GraphQLFieldInput(
      "referencedMessageId",
      graphQLInt.coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    getMessageGraphQLField = field(
  'getMessage',
  listOf(chatMessageGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<ChatMessage?>, Object>,
  description: null,
  resolve: (obj, ctx) {
    final args = ctx.args;

    return getMessage(ctx, (args["chatId"] as int?));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

final GraphQLObjectField<List<ChatMessage?>, Object, Object>
    onMessageSentGraphQLField = field(
  'onMessageSent',
  listOf(chatMessageGraphQlType.nonNull()).nonNull()
      as GraphQLType<List<ChatMessage?>, Object>,
  description: null,
  subscribe: (obj, ctx) {
    final args = ctx.args;

    return onMessageSent(ctx, (args["chatId"] as int));
  },
  inputs: [
    GraphQLFieldInput(
      "chatId",
      graphQLInt.nonNull().coerceToInputObject(),
    )
  ],
  deprecationReason: null,
);

// **************************************************************************
// _GraphQLGenerator
// **************************************************************************

final chatMessageSerializer = SerializerValue<ChatMessage>(
  fromJson: _$$_ChatMessageFromJson,
  toJson: (m) => _$$_ChatMessageToJson(m as _$_ChatMessage),
);
GraphQLObjectType<ChatMessage>? _chatMessageGraphQlType;

/// Auto-generated from [ChatMessage].
GraphQLObjectType<ChatMessage> get chatMessageGraphQlType {
  final __name = 'ChatMessage';
  if (_chatMessageGraphQlType != null)
    return _chatMessageGraphQlType! as GraphQLObjectType<ChatMessage>;

  final __chatMessageGraphQlType = objectType<ChatMessage>('ChatMessage',
      isInterface: false, interfaces: [], description: null);
  _chatMessageGraphQlType = __chatMessageGraphQlType;
  __chatMessageGraphQlType.fields.addAll(
    [
      field('id', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.id,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('userId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.userId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('message', graphQLString.nonNull(),
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('referencedMessageId', graphQLInt,
          resolve: (obj, ctx) => obj.referencedMessageId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('createdAt', graphQLDate.nonNull(),
          resolve: (obj, ctx) => obj.createdAt,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('referencedMessage', chatMessageGraphQlType, resolve: (obj, ctx) {
        final args = ctx.args;

        return obj.referencedMessage(ctx);
      }, inputs: [], description: null, deprecationReason: null)
    ],
  );

  return __chatMessageGraphQlType;
}

final chatMessageSentEventSerializer = SerializerValue<ChatMessageSentEvent>(
  fromJson: _$$ChatMessageSentEventFromJson,
  toJson: (m) => _$$ChatMessageSentEventToJson(m as _$ChatMessageSentEvent),
);
GraphQLObjectType<ChatMessageSentEvent>? _chatMessageSentEventGraphQlType;

/// Auto-generated from [ChatMessageSentEvent].
GraphQLObjectType<ChatMessageSentEvent> get chatMessageSentEventGraphQlType {
  final __name = 'ChatMessageSentEvent';
  if (_chatMessageSentEventGraphQlType != null)
    return _chatMessageSentEventGraphQlType!
        as GraphQLObjectType<ChatMessageSentEvent>;

  final __chatMessageSentEventGraphQlType = objectType<ChatMessageSentEvent>(
      'ChatMessageSentEvent',
      isInterface: false,
      interfaces: [],
      description: null);
  _chatMessageSentEventGraphQlType = __chatMessageSentEventGraphQlType;
  __chatMessageSentEventGraphQlType.fields.addAll(
    [
      field('message', chatMessageGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      chatMessageEventGraphQlTypeDiscriminant()
    ],
  );

  return __chatMessageSentEventGraphQlType;
}

final chatMessageSeletedEventSerializer =
    SerializerValue<ChatMessageSeletedEvent>(
  fromJson: _$$ChatMessageSeletedEventFromJson,
  toJson: (m) =>
      _$$ChatMessageSeletedEventToJson(m as _$ChatMessageSeletedEvent),
);
GraphQLObjectType<ChatMessageSeletedEvent>? _chatMessageSeletedEventGraphQlType;

/// Auto-generated from [ChatMessageSeletedEvent].
GraphQLObjectType<ChatMessageSeletedEvent>
    get chatMessageSeletedEventGraphQlType {
  final __name = 'ChatMessageSeletedEvent';
  if (_chatMessageSeletedEventGraphQlType != null)
    return _chatMessageSeletedEventGraphQlType!
        as GraphQLObjectType<ChatMessageSeletedEvent>;

  final __chatMessageSeletedEventGraphQlType =
      objectType<ChatMessageSeletedEvent>('ChatMessageSeletedEvent',
          isInterface: false, interfaces: [], description: null);
  _chatMessageSeletedEventGraphQlType = __chatMessageSeletedEventGraphQlType;
  __chatMessageSeletedEventGraphQlType.fields.addAll(
    [
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('messageId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.messageId,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      chatMessageEventGraphQlTypeDiscriminant()
    ],
  );

  return __chatMessageSeletedEventGraphQlType;
}

final chatMessageUpdatedInEventSerializer =
    SerializerValue<ChatMessageUpdatedInEvent>(
  fromJson: _$$ChatMessageUpdatedInEventFromJson,
  toJson: (m) =>
      _$$ChatMessageUpdatedInEventToJson(m as _$ChatMessageUpdatedInEvent),
);
GraphQLObjectType<ChatMessageUpdatedInEvent>?
    _chatMessageUpdatedInEventGraphQlType;

/// Auto-generated from [ChatMessageUpdatedInEvent].
GraphQLObjectType<ChatMessageUpdatedInEvent>
    get chatMessageUpdatedInEventGraphQlType {
  final __name = 'ChatMessageUpdatedInEvent';
  if (_chatMessageUpdatedInEventGraphQlType != null)
    return _chatMessageUpdatedInEventGraphQlType!
        as GraphQLObjectType<ChatMessageUpdatedInEvent>;

  final __chatMessageUpdatedInEventGraphQlType =
      objectType<ChatMessageUpdatedInEvent>('ChatMessageUpdatedInEvent',
          isInterface: false, interfaces: [], description: null);
  _chatMessageUpdatedInEventGraphQlType =
      __chatMessageUpdatedInEventGraphQlType;
  __chatMessageUpdatedInEventGraphQlType.fields.addAll(
    [
      field('message', chatMessageGraphQlType.nonNull(),
          resolve: (obj, ctx) => obj.message,
          inputs: [],
          description: null,
          deprecationReason: null),
      field('chatId', graphQLInt.nonNull(),
          resolve: (obj, ctx) => obj.chatId,
          inputs: [],
          description: null,
          deprecationReason: null),
      chatMessageEventGraphQlTypeDiscriminant()
    ],
  );

  return __chatMessageUpdatedInEventGraphQlType;
}

final chatMessageEventSerializer = SerializerValue<ChatMessageEvent>(
  fromJson: _$ChatMessageEventFromJson,
  toJson: (m) => _$ChatMessageEventToJson(m as ChatMessageEvent),
);

Map<String, Object?> _$ChatMessageEventToJson(ChatMessageEvent instance) =>
    instance.toJson();

GraphQLObjectField<String, String, P>
    chatMessageEventGraphQlTypeDiscriminant<P extends ChatMessageEvent>() =>
        field(
          'runtimeType',
          enumTypeFromStrings(
              'ChatMessageEventType', ["sent", "deleted", "updated"]),
        );

GraphQLUnionType<ChatMessageEvent>? _chatMessageEventGraphQlType;
GraphQLUnionType<ChatMessageEvent> get chatMessageEventGraphQlType {
  return _chatMessageEventGraphQlType ??= GraphQLUnionType(
    'ChatMessageEvent',
    [
      chatMessageSentEventGraphQlType,
      chatMessageSeletedEventGraphQlType,
      chatMessageUpdatedInEventGraphQlType
    ],
  );
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatMessage _$$_ChatMessageFromJson(Map<String, dynamic> json) =>
    _$_ChatMessage(
      id: json['id'] as int,
      chatId: json['chatId'] as int,
      userId: json['userId'] as int,
      message: json['message'] as String,
      referencedMessageId: json['referencedMessageId'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_ChatMessageToJson(_$_ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'userId': instance.userId,
      'message': instance.message,
      'referencedMessageId': instance.referencedMessageId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$ChatMessageSentEvent _$$ChatMessageSentEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageSentEvent(
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageSentEventToJson(
        _$ChatMessageSentEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$ChatMessageSeletedEvent _$$ChatMessageSeletedEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageSeletedEvent(
      chatId: json['chatId'] as int,
      messageId: json['messageId'] as int,
    );

Map<String, dynamic> _$$ChatMessageSeletedEventToJson(
        _$ChatMessageSeletedEvent instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'messageId': instance.messageId,
    };

_$ChatMessageUpdatedInEvent _$$ChatMessageUpdatedInEventFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageUpdatedInEvent(
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatMessageUpdatedInEventToJson(
        _$ChatMessageUpdatedInEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
