import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/public_chat_type.dart';

/// Checks whether the maximum number of owned public chats has been reached. Returns corresponding error if the limit was reached. The limit can be increased with Telegram Premium
class CheckCreatedPublicChatsLimit extends TdFunction {
  String get tdType => 'checkCreatedPublicChatsLimit';
  String get tdReturnType => 'Ok';

  /// Type of the public chats, for which to check the limit
  PublicChatType? type;

  CheckCreatedPublicChatsLimit({
    super.extra,
    super.client_id,
    this.type,
  });

  CheckCreatedPublicChatsLimit.fromMap(Map<String, dynamic> map) {
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
