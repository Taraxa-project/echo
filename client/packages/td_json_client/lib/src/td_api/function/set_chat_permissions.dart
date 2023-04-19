import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_permissions.dart';

/// Changes the chat members permissions. Supported only for basic groups and supergroups. Requires can_restrict_members administrator right
class SetChatPermissions extends TdFunction {
  String get tdType => 'setChatPermissions';
  String get tdReturnType => 'Ok';

  /// Chat identifier
  int53? chat_id;

  /// New non-administrator members permissions in the chat
  ChatPermissions? permissions;

  SetChatPermissions({
    super.extra,
    super.client_id,
    this.chat_id,
    this.permissions,
  });

  SetChatPermissions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['permissions'] != null) {
      permissions = TdApiMap.fromMap(map['permissions']) as ChatPermissions;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'permissions': permissions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
