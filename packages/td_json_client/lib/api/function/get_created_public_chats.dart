import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/public_chat_type.dart';


/// Returns a list of public chats of the specified type, owned by the user 
class GetCreatedPublicChats extends TdFunction {
  String get tdType => 'getCreatedPublicChats';
  String get tdReturnType => 'Chats';


  /// Type of the public chats to return
  PublicChatType? type;

  GetCreatedPublicChats({
    super.extra,
    super.client_id,
    this.type,
  });

  GetCreatedPublicChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PublicChatType;
    }
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
