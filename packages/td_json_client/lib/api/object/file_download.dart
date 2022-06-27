import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';

class FileDownload extends TdObject {
  String get tdType => 'fileDownload';

  string? extra;
  int? client_id;
  int32? file_id;
  Message? message;
  int32? add_date;
  int32? complete_date;
  Bool? is_paused;

  FileDownload({
    this.extra,
    this.client_id,
    this.file_id,
    this.message,
    this.add_date,
    this.complete_date,
    this.is_paused,
  });

  FileDownload.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    message = TdApiMap.fromMap(map['message']) as Message;
    add_date = map['add_date'];
    complete_date = map['complete_date'];
    is_paused = map['is_paused'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'add_date': add_date?.toMap(skipNulls: skipNulls),
      'complete_date': complete_date?.toMap(skipNulls: skipNulls),
      'is_paused': is_paused?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
