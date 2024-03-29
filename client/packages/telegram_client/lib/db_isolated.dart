import 'dart:async';

import 'package:logging/logging.dart';
import 'package:sqlite3/sqlite3.dart';

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
    await isolatedProxy.call(DbClose());
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
  Future<Map<String, dynamic>?> selectChat(String username) async {
    return await isolatedProxy.call(SelectChat(username));
  }

  @override
  Future<void> runMigrations() async {
    await isolatedProxy.call(RunMigrations());
  }

  @override
  Future<void> execute(String sql,
      [List<Object?> parameters = const <Object>[]]) async {
    await isolatedProxy.call(Execute(sql, parameters));
  }

  @override
  Future<ResultSet> select(String sql,
      [List<Object?> parameters = const <Object>[]]) async {
    return await isolatedProxy.call(Select(sql, parameters));
  }

  @override
  Future<int> logChatReadStarted(int chatId, DateTime dateTimeStarted) async {
    return await isolatedProxy
        .call(LogChatReadStarted(chatId, dateTimeStarted));
  }

  @override
  Future<void> logChatReadFinished(
      int id, int messageCount, DateTime dateTimeFinished) async {
    await isolatedProxy
        .call(LogChatReadFinished(id, messageCount, dateTimeFinished));
  }

  @override
  Future<int> insertNewChats(String newChatsFullFileName) async {
    return await isolatedProxy.call(InsertNewChats(newChatsFullFileName));
  }

  @override
  Future<bool> isNewChat(String username) async {
    return await isolatedProxy.call(IsNewChat(username));
  }

  @override
  Future<int?> selectNewChatMessageIdLast(String username) async {
    return await isolatedProxy.call(SelectNewChatMessageIdLast(username));
  }

  @override
  Future<bool> messageExists(int chatId, int id) async {
    return await isolatedProxy.call(MessageExists(chatId, id));
  }

  @override
  Future<int?> selectNewChatStatus(String username) async {
    return await isolatedProxy.call(SelectNewChatStatus(username));
  }

  @override
  Future<void> updateNewChat(
      String username, int messageIdLast, int status) async {
    await isolatedProxy.call(UpdateNewChat(username, messageIdLast, status));
  }

  @override
  Future<void> exportPrepare() async {
    await isolatedProxy.call(ExportPrepare());
  }

  @override
  Future<ExportResult?> exportNextData(String fileName) async {
    return await isolatedProxy.call(ExportNextData(fileName));
  }

  @override
  Future<ExportResult?> exportNextMeta(String fileName) async {
    return await isolatedProxy.call(ExportNextMeta(fileName));
  }

  @override
  Future<void> updateDataCid(int rowid, String cid) async {
    await isolatedProxy.call(UpdateDataCid(rowid, cid));
  }

  @override
  Future<void> updateMetaCid(int rowid, String cid) async {
    await isolatedProxy.call(UpdateMetaCid(rowid, cid));
  }

  @override
  Future<UnpinNextResult?> unpinNextData() async {
    return await isolatedProxy.call(UnpinNextData());
  }

  @override
  Future<UnpinNextResult?> unpinNextMeta() async {
    return await isolatedProxy.call(UnpinNextMeta());
  }

  @override
  Future<void> clearDataCid(int rowid) async {
    await isolatedProxy.call(ClearDataCid(rowid));
  }

  @override
  Future<void> clearDataCidOld(int rowid) async {
    await isolatedProxy.call(ClearDataCidOld(rowid));
  }

  @override
  Future<void> clearMetaCid(int rowid) async {
    await isolatedProxy.call(ClearMetaCid(rowid));
  }

  @override
  Future<void> clearMetaCidOld(int rowid) async {
    await isolatedProxy.call(ClearMetaCidOld(rowid));
  }

  @override
  Future<void> clearCids() async {
    await isolatedProxy.call(ClearCids());
  }

  @override
  Future<void> updateChatSupergroupFullInfo(
      String username, SupergroupFullInfo supergroupFullInfo) async {
    await isolatedProxy
        .call(UpdateChatSupergroupFullInfo(username, supergroupFullInfo));
  }

  @override
  Future<void> updateChatSupergroup(
      String username, Supergroup supergroup) async {
    await isolatedProxy.call(UpdateChatSupergroup(username, supergroup));
  }
}

class DbIsolatedDispatch extends IsolatedDispatch {
  final Db db;

  DbIsolatedDispatch(this.db) {}

  dynamic dispatch(message) async {
    if (message is DbClose) {
      db.close();
    } else if (message is InsertChats) {
      db.insertChats(message.usernames);
    } else if (message is BlacklistChat) {
      db.blacklistChat(message.username, message.reason);
    } else if (message is UpdateChat) {
      db.updateChat(message.username, message.chat);
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
    } else if (message is SelectMetaFileHahes) {
      return db.selectMetaFileHahes();
    } else if (message is SelectChat) {
      return db.selectChat(message.username);
    } else if (message is RunMigrations) {
      return db.runMigrations();
    } else if (message is Execute) {
      db.execute(message.sql, message.parameters);
    } else if (message is Select) {
      return db.select(message.sql, message.parameters);
    } else if (message is LogChatReadStarted) {
      return db.logChatReadStarted(message.chatId, message.dateTimeStarted);
    } else if (message is LogChatReadFinished) {
      db.logChatReadFinished(
          message.id, message.messageCount, message.dateTimeFinished);
    } else if (message is InsertNewChats) {
      return db.insertNewChats(message.newChatsFullFileName);
    } else if (message is IsNewChat) {
      return db.isNewChat(message.username);
    } else if (message is SelectNewChatMessageIdLast) {
      return db.selectNewChatMessageIdLast(message.username);
    } else if (message is MessageExists) {
      return db.messageExists(message.chatId, message.id);
    } else if (message is SelectNewChatStatus) {
      return db.selectNewChatStatus(message.username);
    } else if (message is UpdateNewChat) {
      return db.updateNewChat(
          message.username, message.messageIdLast, message.status);
    } else if (message is ExportPrepare) {
      db.exportPrepare();
    } else if (message is ExportNextData) {
      return await db.exportNextData(message.fileName);
    } else if (message is ExportNextMeta) {
      return await db.exportNextMeta(message.fileName);
    } else if (message is UpdateDataCid) {
      db.updateDataCid(message.rowid, message.cid);
    } else if (message is UpdateMetaCid) {
      db.updateMetaCid(message.rowid, message.cid);
    } else if (message is UnpinNextData) {
      return db.unpinNextData();
    } else if (message is UnpinNextMeta) {
      return db.unpinNextMeta();
    } else if (message is ClearDataCid) {
      db.clearDataCid(message.rowid);
    } else if (message is ClearDataCidOld) {
      db.clearDataCidOld(message.rowid);
    } else if (message is ClearMetaCid) {
      db.clearMetaCid(message.rowid);
    } else if (message is ClearMetaCidOld) {
      db.clearMetaCidOld(message.rowid);
    } else if (message is ClearCids) {
      db.clearCids();
    } else if (message is UpdateChatSupergroupFullInfo) {
      db.updateChatSupergroupFullInfo(
          message.username, message.supergroupFullInfo);
    } else if (message is UpdateChatSupergroup) {
      db.updateChatSupergroup(message.username, message.supergroup);
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

class DbClose {}

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

class SelectMetaFileHahes {}

class RunMigrations {}

class Execute {
  final String sql;
  final List<Object?> parameters;

  Execute(this.sql, [this.parameters = const <Object>[]]);
}

class Select {
  final String sql;
  final List<Object?> parameters;

  Select(this.sql, [this.parameters = const <Object>[]]);
}

class LogChatReadStarted {
  final int chatId;
  final DateTime dateTimeStarted;

  LogChatReadStarted(this.chatId, this.dateTimeStarted);
}

class LogChatReadFinished {
  final int id;
  final int messageCount;
  final DateTime dateTimeFinished;

  LogChatReadFinished(this.id, this.messageCount, this.dateTimeFinished);
}

class InsertNewChats {
  final String newChatsFullFileName;

  InsertNewChats(this.newChatsFullFileName);
}

class IsNewChat {
  final String username;

  IsNewChat(this.username);
}

class SelectNewChatStatus {
  final String username;

  SelectNewChatStatus(this.username);
}

class SelectNewChatMessageIdLast {
  final String username;

  SelectNewChatMessageIdLast(this.username);
}

class MessageExists {
  final int chatId;
  final int id;

  MessageExists(this.chatId, this.id);
}

class UpdateNewChat {
  final String username;
  final int messageIdLast;
  final int status;

  UpdateNewChat(this.username, this.messageIdLast, this.status);
}

class ExportPrepare {}

class ExportNextData {
  String fileName;

  ExportNextData(this.fileName);
}

class ExportNextMeta {
  String fileName;

  ExportNextMeta(this.fileName);
}

class UpdateDataCid {
  final int rowid;
  final String cid;

  UpdateDataCid(this.rowid, this.cid);
}

class UpdateMetaCid {
  final int rowid;
  final String cid;

  UpdateMetaCid(this.rowid, this.cid);
}

class UnpinNextData {}

class UnpinNextMeta {}

class ClearDataCid {
  final int rowid;

  ClearDataCid(this.rowid);
}

class ClearDataCidOld {
  final int rowid;

  ClearDataCidOld(this.rowid);
}

class ClearMetaCid {
  final int rowid;

  ClearMetaCid(this.rowid);
}

class ClearMetaCidOld {
  final int rowid;

  ClearMetaCidOld(this.rowid);
}

class ClearCids {}

class UpdateChatSupergroupFullInfo {
  final String username;
  final SupergroupFullInfo supergroupFullInfo;

  UpdateChatSupergroupFullInfo(this.username, this.supergroupFullInfo);
}

class UpdateChatSupergroup {
  final String username;
  final Supergroup supergroup;

  UpdateChatSupergroup(this.username, this.supergroup);
}
