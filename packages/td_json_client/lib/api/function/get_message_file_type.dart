import 'package:td_json_client/api/base.dart';


/// Returns information about a file with messages exported from another application 
class GetMessageFileType extends TdFunction {
  String get tdType => 'getMessageFileType';
  String get tdReturnType => 'MessageFileType';


  /// Beginning of the message file; up to 100 first lines
  string? message_file_head;

  GetMessageFileType({
    super.extra,
    super.client_id,
    this.message_file_head,
  });

  GetMessageFileType.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_file_head = map['message_file_head'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_file_head': message_file_head?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
