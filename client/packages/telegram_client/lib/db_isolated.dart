import 'dart:async';

import 'package:logging/logging.dart';

import 'package:td_json_client/td_api.dart';

import 'db_interface.dart';
import 'db.dart';
import 'isolate.dart';
import 'log_isolated.dart';

class DbIsolated implements DbInterface {
  final IsolatedProxy isolatedProxy;

  DbIsolated._(this.isolatedProxy);

  static Future<DbIsolated> spawn(
    LogIsolated log,
    String filename, [
    String? debugName,
  ]) async {
    final init = Init(filename, log);
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
      ..level = init.log.level
      ..onRecord.listen((event) {
        init.log.logExternal(event);
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
  Future<void> blacklistChat(String username, String reason) async {
    await isolatedProxy.call(BlacklistChat(username, reason));
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
  Future<int> exportData(String tableName, String fileName, int? fromId) async {
    return await isolatedProxy.call(ExportData(tableName, fileName, fromId));
  }

  @override
  Future<void> insertIpfsHash(String tableName, String fileHash) async {
    await isolatedProxy.call(InsertIpfsHash(tableName, fileHash));
  }

  @override
  Future<int> exportMeta(String tableName, String fileName) async {
    return await isolatedProxy.call(ExportMeta(tableName, fileName));
  }

  @override
  Future<void> updateMetaFileHash(String tableName, String fileHash) async {
    await isolatedProxy.call(UpdateMetaFileHash(tableName, fileHash));
  }

  @override
  Future<IfpsFileHashesMeta> selectMetaFileHahes() async {
    return await isolatedProxy.call(SelectMetaFileHahes());
  }

  @override
  Future<bool> userExists(int userId) async {
    return await isolatedProxy.call(UserExists(userId));
  }

  @override
  Future<void> insertMessagesUsers(
      List<Message> messages, List<User> users, int? onlineMembersCount) async {
    await isolatedProxy
        .call(InsertMessagesUsers(messages, users, onlineMembersCount));
  }

  @override
  Future<DateTime?> selectLastExportDateTime() async {
    return await isolatedProxy.call(SelectLastExportDateTime());
  }

  @override
  Future<Map<String, dynamic>?> selectChat(String username) async {
    return await isolatedProxy.call(SelectChat(username));
  }
}

class DbIsolatedDispatch extends IsolatedDispatch {
  final Db db;

  DbIsolatedDispatch(this.db) {}

  dynamic dispatch(message) async {
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
    } else if (message is UserExists) {
      return db.userExists(message.userId);
    } else if (message is InsertMessagesUsers) {
      db.insertMessagesUsers(
          message.messages, message.users, message.onlineMembersCount);
    } else if (message is ExportData) {
      return await db.exportData(
          message.tableName, message.fileName, message.fromId);
    } else if (message is InsertIpfsHash) {
      db.insertIpfsHash(message.tableName, message.fileHash);
    } else if (message is ExportMeta) {
      return await db.exportMeta(message.tableName, message.fileName);
    } else if (message is UpdateMetaFileHash) {
      db.updateMetaFileHash(message.tableName, message.fileHash);
    } else if (message is SelectMetaFileHahes) {
      return db.selectMetaFileHahes();
    } else if (message is SelectLastExportDateTime) {
      return db.selectLastExportDateTime();
    } else if (message is SelectChat) {
      return db.selectChat(message.username);
    } else {
      return super.dispatch(message);
    }
  }
}

class Init {
  final String filename;
  final LogIsolated log;

  Init(this.filename, this.log);
}

class Close {}

class InsertChats {
  final List<String> usernames;

  InsertChats(this.usernames);
}

class SelectChat {
  final String username;

  SelectChat(this.username);
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

class UserExists {
  final int userId;

  UserExists(this.userId);
}

class InsertMessagesUsers {
  final List<Message> messages;
  final List<User> users;
  final int? onlineMembersCount;

  InsertMessagesUsers(this.messages, this.users, this.onlineMembersCount);
}

class ExportData {
  final String tableName;
  final String fileName;
  int? fromId;

  ExportData(this.tableName, this.fileName, this.fromId);
}

class InsertIpfsHash {
  final String tableName;
  final String fileHash;

  InsertIpfsHash(this.tableName, this.fileHash);
}

class ExportMeta {
  final String tableName;
  final String fileName;

  ExportMeta(this.tableName, this.fileName);
}

class UpdateMetaFileHash {
  final String tableName;
  final String fileHash;

  UpdateMetaFileHash(this.tableName, this.fileHash);
}

class SelectMetaFileHahes {}

class SelectLastExportDateTime {}
