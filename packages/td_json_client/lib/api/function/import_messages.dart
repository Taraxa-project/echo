import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Imports messages exported from another app
class ImportMessages extends TdFunction {
  String get tdType => 'importMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Identifier of a chat to which the messages will be imported. It must be an identifier of a private chat with a mutual contact or an identifier of a supergroup chat with can_change_info administrator right
  int53? chat_id;

  /// File with messages to import. Only inputFileLocal and inputFileGenerated are supported. The file must not be previously uploaded
  InputFile? message_file;

  /// Files used in the imported messages. Only inputFileLocal and inputFileGenerated are supported. The files must not be previously uploaded
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
