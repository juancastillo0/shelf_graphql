// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shelf_graphql/shelf_graphql.dart';
import 'package:shelf_graphql_example/schema/books.controller.dart';
import 'package:shelf_graphql_example/schema/chat_room.dart/sql_utils.dart';
import 'package:sqlite3/sqlite3.dart';

part 'chat_table.g.dart';
part 'chat_table.freezed.dart';

final chatRoomDatabase = GlobalRef('ChatRoomDatabase');

final chatControllerRef = RefWithDefault(
  'ChatController',
  (globals) => ChatController.create(
    db: globals[chatRoomDatabase] as Database?,
  ),
);

class ChatController {
  final ChatTable chats;
  final ChatMessageTable messages;

  ChatController({
    required this.chats,
    required this.messages,
  });

  static Future<ChatController> create({Database? db}) async {
    final _db = db ?? sqlite3.open('chat_room.sqlite');
    _db.execute('PRAGMA foreign_keys = ON;');

    final chats = ChatTable(_db);
    await chats.setup();
    final messages = ChatMessageTable(_db);
    await messages.setup();

    return ChatController(chats: chats, messages: messages);
  }
}

class ChatTable {
  final Database db;

  ChatTable(this.db);

  ChatRoom? insert(String name) {
    db.execute('INSERT INTO chat(name) VALUES (?)', [name]);

    return get(db.lastInsertRowId);
  }

  ChatRoom? get(int chatId) {
    final result = db.select(
      'SELECT * FROM chat WHERE id = ?;',
      [chatId],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatRoom.fromJson(result.first);
  }

  Future<List<ChatRoom>> getAll() async {
    final result = db.select(
      '''SELECT * FROM chat;''',
    );
    final values = result.map((e) => ChatRoom.fromJson(e)).toList();
    return values;
  }

  Future<void> setup() async {
    const tableName = 'chat';
    final migrated = migrate(
      db,
      tableName,
      [
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  name TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id)
);''',
      ],
    );
    print('migrated $tableName $migrated');
  }
}

class ChatMessageTable {
  final Database db;

  final controller = StreamController<ChatMessage>.broadcast();

  ChatMessageTable(this.db) {
    controller.stream.listen((event) {
      print(event);
    });
  }

  Future<List<ChatMessage>> getAll({int? chatId}) async {
    final result = db.select(
      '''
SELECT * FROM message ${chatId == null ? '' : 'WHERE chatId = ?'};
''',
      [if (chatId != null) chatId],
    );
    final values = result.map((e) => ChatMessage.fromJson(e)).toList();
    return values;
  }

  Future<ChatMessage?> get(int id) async {
    final result = db.select(
      '''SELECT * FROM message WHERE id = ?;''',
      [id],
    );
    if (result.isEmpty) {
      return null;
    }
    return ChatMessage.fromJson(result.first);
  }

  Future<ChatMessage?> insert(
    int chatId,
    String message, {
    int? referencedMessageId,
  }) async {
    bool success = false;
    try {
      if (referencedMessageId != null) {
        db.execute('BEGIN TRANSACTION;');
        final referencedMessage = await get(referencedMessageId);
        if (referencedMessage == null) {
          throw Exception(
              'Chat message with id $referencedMessageId not found.');
        } else if (referencedMessage.chatId != chatId) {
          throw Exception('Can only reference messages within the same chat.');
        }
      }
      db.execute(
        referencedMessageId == null
            ? '''INSERT INTO message(chatId, message) VALUES (?, ?)'''
            : '''INSERT INTO message(chatId, message, referencedMessageId) VALUES (?, ?, ?)''',
        [chatId, message, if (referencedMessageId != null) referencedMessageId],
      );
      success = true;
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 787) {
        throw Exception('Chat room with id $chatId not found.');
      }
      return null;
    } finally {
      if (referencedMessageId != null) {
        if (success) {
          db.execute('COMMIT;');
        } else {
          db.execute('ROLLBACK;');
        }
      }
    }

    final messageModel = await get(db.lastInsertRowId);
    if (messageModel != null) {
      controller.add(messageModel);
    }
    return messageModel;
  }

  Future<void> setup() async {
    const tableName = 'message';
    final migrated = migrate(
      db,
      tableName,
      [
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  message TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id),
  FOREIGN KEY (chatId) REFERENCES chat (id)
);''',

        /// Change DEFAULT CURRENT_DATE -> DEFAULT CURRENT_TIMESTAMP
        'ALTER TABLE $tableName RENAME TO tmp_$tableName;',
        '''\
CREATE TABLE $tableName (
  id INTEGER NOT NULL,
  chatId INTEGER NOT NULL,
  message TEXT NOT NULL,
  createdAt DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (chatId) REFERENCES chat (id)
);''',
        '''\
INSERT INTO $tableName(id, chatId, message, createdAt) 
SELECT id, chatId, message, createdAt
FROM tmp_$tableName;''',
        'DROP TABLE tmp_$tableName;',

        /// Add referencedMessageId column
        '''
ALTER TABLE $tableName ADD referencedMessageId INT NULL
REFERENCES $tableName (id);''',
      ],
    );
    print('migrated $tableName $migrated');
  }
}

@GraphQLClass()
@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required int id,
    required String name,
    required DateTime createdAt,
  }) = _ChatRoom;
  const ChatRoom._();

  factory ChatRoom.fromJson(Map<String, Object?> json) =>
      _$ChatRoomFromJson(json);

  Future<List<ChatMessage>> messages(ReqCtx<Object> ctx) async {
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.getAll(chatId: id);
  }
}

@GraphQLClass()
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required int id,
    required int chatId,
    required String message,
    int? referencedMessageId,
    required DateTime createdAt,
  }) = _ChatMessage;
  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);

  Future<ChatMessage?> referencedMessage(ReqCtx ctx) async {
    if (referencedMessageId == null) {
      return null;
    }
    final controller = await chatControllerRef.get(ctx);
    return controller.messages.get(referencedMessageId!);
  }
}

@Mutation()
Future<ChatMessage?> sendMessage(
  ReqCtx<Object> ctx,
  int chatId,
  String message,
  int? referencedMessageId,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.insert(
    chatId,
    message,
    referencedMessageId: referencedMessageId,
  );
}

@Query()
Future<List<ChatMessage>> getMessage(
  ReqCtx<Object> ctx,
  int? chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.messages.getAll(chatId: chatId);
}

@Subscription()
Future<Stream<List<ChatMessage>>> onMessageSent(
  ReqCtx<Object> ctx,
  int chatId,
) async {
  final controller = await chatControllerRef.get(ctx);
  final chat = controller.chats.get(chatId);
  if (chat == null) {
    throw GraphQLExceptionError('Chat with id $chatId not found.');
  }
  return controller.messages.controller.stream
      .where((event) => event.chatId == chatId)
      .asyncMap((event) => controller.messages.getAll(chatId: chatId));
}

@Mutation()
Future<ChatRoom?> createChatRoom(
  ReqCtx<Object> ctx,
  String name,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.insert(name);
}

@Query()
Future<List<ChatRoom>> getChatRooms(
  ReqCtx<Object> ctx,
) async {
  final controller = await chatControllerRef.get(ctx);
  return controller.chats.getAll();
}