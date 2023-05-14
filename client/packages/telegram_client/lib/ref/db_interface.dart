import 'dart:async';

import 'package:td_json_client/td_api.dart';

abstract class DbInterface {
  FutureOr<void> close();

  FutureOr<void> insertChats(List<String> usernames);
  FutureOr<void> blacklistChat(String username, String reason);
  FutureOr<void> updateChat(String username, Chat chat);
  FutureOr<void> updateChatMembersCount(String username, int membersCount);
  FutureOr<void> updateChatMembersOnlineCount(
      String username, int membersOnlineCount);
  FutureOr<void> updateChatBotsCount(String username, int botsCount);
  FutureOr<int?> selectChatOnlineMembersCount(String username);

  FutureOr<int?> selectMaxMessageIdFromDate(int chatId, DateTime dateTimeFrom);
  FutureOr<void> insertMessage(Message message, int? onlineMembersCount);

  FutureOr<void> insertUser(int userId);
  FutureOr<void> updateUser(int userId, User user);

  FutureOr<void> updateMetaFileHash(String tableName, String fileHash);
  FutureOr<IfpsFileHashesMeta> selectMetaFileHahes();

  FutureOr<void> insertIpfsHash(String tableName, String fileHash);

  FutureOr<int> exportData(String tableName, String fileName, int? fromId);
  FutureOr<int> exportMeta(String tableName, String fileName);
}

class IfpsFileHashesMeta {
  String? chat;
  String? message;
  String? user;
}
