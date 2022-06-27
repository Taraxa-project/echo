import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class ImportMessages extends TdFunction {
  String get tdType => 'importMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int53? chat_id;
  InputFile? message_file;
  vector<InputFile>? attached_files;

  ImportMessages({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_file,
    this.attached_files,
  });

  ImportMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_file = TdApiMap.fromMap(map['message_file']) as InputFile;
    if (map['attached_files']) {
      attached_files = [];
      for (var someValue in map['attached_files']) {
        attached_files?.add(TdApiMap.fromMap(someValue) as InputFile);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_file': message_file?.toMap(skipNulls: skipNulls),
      'attached_files': attached_files?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
