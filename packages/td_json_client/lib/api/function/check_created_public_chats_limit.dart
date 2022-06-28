import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/public_chat_type.dart';


/// Checks whether the maximum number of owned public chats has been reached. Returns corresponding error if the limit was reached 
class CheckCreatedPublicChatsLimit extends TdFunction {
  String get tdType => 'checkCreatedPublicChatsLimit';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Type of the public chats, for which to check the limit
  PublicChatType? type;

  CheckCreatedPublicChatsLimit({
    this.extra,
    this.client_id,
    this.type,
  });

  CheckCreatedPublicChatsLimit.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = TdApiMap.fromMap(map['type']) as PublicChatType;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
