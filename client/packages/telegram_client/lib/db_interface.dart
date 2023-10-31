import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import 'package:td_json_client/td_api.dart';

abstract class DbInterface {
  FutureOr<void> close();

  FutureOr<void> runMigrations();

  FutureOr<void> execute(String sql,
      [List<Object?> parameters = const <Object>[]]);
  FutureOr<ResultSet> select(String sql,
      [List<Object?> parameters = const <Object>[]]);

  FutureOr<Map<String, dynamic>?> selectChat(String username);
  FutureOr<void> insertChats(List<String> usernames);
  FutureOr<void> blacklistChat(String username, String reason);
  FutureOr<void> updateChat(String username, Chat chat);
  FutureOr<void> updateChatMembersCount(String username, int membersCount);
  FutureOr<void> updateChatMembersOnlineCount(
      String username, int membersOnlineCount);
  FutureOr<void> updateChatBotsCount(String username, int botsCount);
  FutureOr<int?> selectChatOnlineMembersCount(String username);

  FutureOr<int?> selectMaxMessageIdFromDate(int chatId, DateTime dateTimeFrom);

  FutureOr<bool> userExists(int userId);

  FutureOr<void> insertMessagesUsers(
      List<Message> messages, List<User> users, int? onlineMembersCount);

  FutureOr<IfpsFileHashesMeta> selectMetaFileHahes();

  FutureOr<int> logChatReadStarted(int chatId, DateTime dateTimeStarted);
  FutureOr<void> logChatReadFinished(
      int id, int messageCount, DateTime dateTimeFinished);

  FutureOr<int> insertNewChats(String newChatsFullFileName);
  FutureOr<bool> isNewChat(String username);
  FutureOr<int?> selectNewChatMessageIdLast(String username);
  FutureOr<bool> messageExists(int chatId, int id);
  FutureOr<int?> selectNewChatStatus(String username);
  FutureOr<void> updateNewChat(String username, int messageIdLast, int status);

  FutureOr<void> exportPrepare();
  FutureOr<ExportDataResult?> exportNextData(String fileName);
  FutureOr<ExportDataResult?> exportNextMeta(String fileName);
  FutureOr<void> updateDataCid(int rowid, String cid);
  FutureOr<void> updateMetaCid(int rowid, String cid);
}

class IfpsFileHashesMeta {
  String? chat;
  String? message;
  String? user;
}

const int exportRecordLimit = 10000;

class ExportException implements Exception {
  final String? message;

  ExportException([this.message = '']);

  String toString() {
    var report = 'ExportException';
    if (message != null) {
      report += ': $message';
    }
    return report;
  }
}

class ExportDataResult {
  final String type;
  final int rowid;
  final String? cid_old;

  ExportDataResult(this.type, this.rowid, this.cid_old);
}
