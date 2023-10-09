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

  FutureOr<void> updateMetaFileHash(String tableName, String fileHash);
  FutureOr<IfpsFileHashesMeta> selectMetaFileHahes();

  FutureOr<void> insertIpfsHash(ExportType exportType, String fileHash);

  FutureOr<int> exportData(ExportType exportType);
  FutureOr<int> exportMeta(ExportType exportType);

  FutureOr<DateTime?> selectLastExportDateTime();

  FutureOr<int> logChatReadStarted(int chatId, DateTime dateTimeStarted);
  FutureOr<void> logChatReadFinished(
      int id, int messageCount, DateTime dateTimeFinished);

  FutureOr<int> insertNewChats(String newChatsFullFileName);
  FutureOr<bool> isNewChat(String username);
  FutureOr<int?> selectNewChatMessageIdLast(String username);
  FutureOr<bool> messageExists(int chatId, int id);
  FutureOr<int?> selectNewChatStatus(String username);
  FutureOr<void> updateNewChat(String username, int messageIdLast, int status);
}

class IfpsFileHashesMeta {
  String? chat;
  String? message;
  String? user;
}

const int exportRecordLimit = 10000;

abstract class ExportType {
  final String workDir;
  final String fileExtensionName = 'json_lines';

  String get dataType;

  int limit;

  ExportType(this.workDir, [this.limit = exportRecordLimit]);

  String get fileNameFullPathData {
    return p.joinAll([workDir, '${dataType}.${fileExtensionName}']);
  }

  String get fileNameFullPathMeta {
    return p.joinAll([workDir, '${dataType}.meta.${fileExtensionName}']);
  }
}

class ExportTypeChat extends ExportType {
  String get dataType => 'chat';

  ExportTypeChat(super.exportDataTypeFile, [super.limit = exportRecordLimit]);
}

class ExportTypeMessage extends ExportType {
  String get dataType => 'message';

  ExportTypeMessage(super.exportDataTypeFile,
      [super.limit = exportRecordLimit]);
}

class ExportTypeUser extends ExportType {
  String get dataType => 'user';

  ExportTypeUser(super.exportDataTypeFile, [super.limit = exportRecordLimit]);
}

class ExportTypeChatRead extends ExportType {
  String get dataType => 'chat.${chatId}';

  final int chatId;
  final DateTime dateTimeFrom;

  ExportTypeChatRead(super.exportDataTypeFile, this.chatId, this.dateTimeFrom,
      [super.limit = exportRecordLimit]);
}
