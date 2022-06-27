import 'package:td_json_client/api/base.dart';

class AddFileToDownloads extends TdFunction {
  String get tdType => 'addFileToDownloads';
  String get tdReturnType => 'File';

  string? extra;
  int? client_id;
  int32? file_id;
  int53? chat_id;
  int53? message_id;
  int32? priority;

  AddFileToDownloads({
    this.extra,
    this.client_id,
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
