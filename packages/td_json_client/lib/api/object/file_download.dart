import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/message.dart';


/// Describes a file added to file download list
class FileDownload extends TdObject {
  String get tdType => 'fileDownload';

  String? extra;
  int? client_id;

  /// File identifier
  int32? file_id;

  /// The message with the file
  Message? message;

  /// Point in time (Unix timestamp) when the file was added to the download list
  int32? add_date;

  /// Point in time (Unix timestamp) when the file downloading was completed; 0 if the file downloading isn't completed
  int32? complete_date;

  /// True, if downloading of the file is paused
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
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as Message;
    }
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
