import 'dart:async';

import 'package:sqlite3/sqlite3.dart';

import 'package:td_json_client/td_api.dart';

abstract class DbInterface {
  FutureOr<void> close();

  FutureOr<void> runMigrations();

  FutureOr<void> execute(String sql, List<Object?> parameters);
  FutureOr<ResultSet> select(String sql, List<Object?> parameters);

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

  FutureOr<void> updateMetaFileHash(String tableName, String fileHash);
  FutureOr<IfpsFileHashesMeta> selectMetaFileHahes();

  FutureOr<void> insertIpfsHash(String tableName, String fileHash);

  FutureOr<int> exportData(
      String tableName, String fileName, int? fromId, int limit);
  FutureOr<int> exportMeta(String tableName, String fileName);

  FutureOr<DateTime?> selectLastExportDateTime();
}

class IfpsFileHashesMeta {
  String? chat;
  String? message;
  String? user;
}
