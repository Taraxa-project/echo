import 'dart:async';

import 'package:logging/logging.dart';

import 'package:td_json_client/src/td_api/object/chat.dart';
import 'package:td_json_client/td_api.dart';
import 'package:telegram_client/ref/lg_isolated.dart';

import 'db_interface.dart';
import 'db.dart';
import 'isolate.dart';

class DbIsolated implements DbInterface {
  final IsolatedProxy isolatedProxy;

  DbIsolated._(this.isolatedProxy);

  static Future<DbIsolated> spawn(
    LgIsolated lg,
    String filename, [
    String? debugName,
  ]) async {
    final init = Init(filename, lg);
    final sendPort =
        await Isolater.spawn(DbIsolated._entryPoint, init, debugName);
    final isolatedProxy = IsolatedProxy(sendPort);
    return DbIsolated._(isolatedProxy);
  }

  static void _entryPoint(message) {
    hierarchicalLoggingEnabled = true;

    final isolateSpawnMessage = message as IsolateSpawnMessage;
    final init = isolateSpawnMessage.init as Init;

    final logger = Logger('Db')
      ..level = init.lg.level
      ..onRecord.listen((event) {
        init.lg.logExternal(event);
      });

    final db = Db(logger, init.filename);
    final isolatedDispatch = DbIsolatedDispatch(db);

    isolateSpawnMessage.sendPort.send(isolatedDispatch.receivePort.sendPort);
  }

  @override
  Future<void> close() async {
    await isolatedProxy.call(Close());
    isolatedProxy.exit();
  }

  @override
  Future<void> insertChats(List<String> usernames) async {
    await isolatedProxy.call(InsertChats(usernames));
  }

  @override
  Future<void> updateChat(String username, Chat chat) async {
    await isolatedProxy.call(UpdateChat(username, chat));
  }

  @override
  FutureOr<void> blacklistChat(String username, String reason) async {
    await isolatedProxy.call(BlacklistChat(username, username));
  }

  @override
  Future<void> updateChatMembersCount(String username, int membersCount) async {
    await isolatedProxy.call(UpdateChatMembersCount(username, membersCount));
  }

  @override
  Future<void> updateChatMembersOnlineCount(
      String username, int membersOnlineCount) async {
    await isolatedProxy
        .call(UpdateChatMembersOnlineCount(username, membersOnlineCount));
  }

  @override
  Future<void> updateChatBotsCount(String username, int botsCount) async {
    await isolatedProxy.call(UpdateChatBotsCount(username, botsCount));
  }

  @override
  Future<int?> selectChatOnlineMembersCount(String username) async {
    return await isolatedProxy.call(SelectChatOnlineMembersCount(username));
  }

  @override
  Future<int?> selectMaxMessageIdFromDate(
      int chatId, DateTime dateTimeFrom) async {
    return await isolatedProxy
        .call(SelectMaxMessageIdFromDate(chatId, dateTimeFrom));
  }

  @override
  Future<void> insertMessage(Message message, int? onlineMembersCount) async {
    await isolatedProxy.call(InsertMessage(message, onlineMembersCount));
  }

  @override
  Future<void> insertUser(int userId) async {
    await isolatedProxy.call(InsertUser(userId));
  }

  @override
  Future<void> updateUser(int userId, User user) async {
    await isolatedProxy.call(UpdateUser(userId, user));
  }
}

class DbIsolatedDispatch extends IsolatedDispatch {
  final Db db;

  DbIsolatedDispatch(this.db) {}

  dynamic dispatch(message) {
    if (message is Close) {
      db.close();
    } else if (message is InsertChats) {
      db.insertChats(message.usernames);
    } else if (message is BlacklistChat) {
      db.blacklistChat(message.username, message.reason);
    } else if (message is UpdateChat) {
      db.updateChat(message.username, message.chat);
    } else if (message is UpdateChatMembersCount) {
      db.updateChatMembersCount(message.username, message.membersCount);
    } else if (message is UpdateChatMembersOnlineCount) {
      db.updateChatMembersOnlineCount(
          message.username, message.membersOnlineCount);
    } else if (message is UpdateChatBotsCount) {
      db.updateChatBotsCount(message.username, message.botsCount);
    } else if (message is SelectChatOnlineMembersCount) {
      return db.selectChatOnlineMembersCount(message.username);
    } else if (message is SelectMaxMessageIdFromDate) {
      return db.selectMaxMessageIdFromDate(
          message.chatId, message.dateTimeFrom);
    } else if (message is InsertMessage) {
      db.insertMessage(message.message, message.onlineMembersCount);
    } else if (message is InsertUser) {
      db.insertUser(message.userId);
    } else if (message is UpdateUser) {
      db.updateUser(message.userId, message.user);
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final String filename;
  final LgIsolated lg;

  Init(this.filename, this.lg);
}

class Close {}

class InsertChats {
  final List<String> usernames;

  InsertChats(this.usernames);
}

class BlacklistChat {
  final String username;
  final String reason;

  BlacklistChat(this.username, this.reason);
}

class UpdateChat {
  final String username;
  final Chat chat;

  UpdateChat(this.username, this.chat);
}

class UpdateChatMembersCount {
  final String username;
  final int membersCount;

  UpdateChatMembersCount(this.username, this.membersCount);
}

class UpdateChatMembersOnlineCount {
  final String username;
  final int membersOnlineCount;

  UpdateChatMembersOnlineCount(this.username, this.membersOnlineCount);
}

class UpdateChatBotsCount {
  final String username;
  final int botsCount;

  UpdateChatBotsCount(this.username, this.botsCount);
}

class SelectChatOnlineMembersCount {
  final String username;

  SelectChatOnlineMembersCount(this.username);
}

class SelectMaxMessageIdFromDate {
  final int chatId;
  final DateTime dateTimeFrom;

  SelectMaxMessageIdFromDate(this.chatId, this.dateTimeFrom);
}

class InsertMessage {
  final Message message;
  final int? onlineMembersCount;

  InsertMessage(this.message, this.onlineMembersCount);
}

class InsertUser {
  final int userId;

  InsertUser(this.userId);
}

class UpdateUser {
  final int userId;
  final User user;

  UpdateUser(this.userId, this.user);
}
