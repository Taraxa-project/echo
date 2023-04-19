import 'package:td_json_client/src/td_api/td.dart';

/// Adds a file from a message to the list of file downloads. Download progress and completion of the download will be notified through updateFile updates.
/// If message database is used, the list of file downloads is persistent across application restarts. The downloading is independent from download using downloadFile, i.e. it continues if downloadFile is canceled or is used to download a part of the file
class AddFileToDownloads extends TdFunction {
  String get tdType => 'addFileToDownloads';
  String get tdReturnType => 'File';

  /// Identifier of the file to download
  int32? file_id;

  /// Chat identifier of the message with the file
  int53? chat_id;

  /// Message identifier
  int53? message_id;

  /// Priority of the download (1-32). The higher the priority, the earlier the file will be downloaded. If the priorities of two files are equal, then the last one for which downloadFile/addFileToDownloads was called will be downloaded first
  int32? priority;

  AddFileToDownloads({
    super.extra,
    super.client_id,
    this.file_id,
    this.chat_id,
    this.message_id,
    this.priority,
  });

  AddFileToDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    priority = map['priority'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'priority': priority?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
