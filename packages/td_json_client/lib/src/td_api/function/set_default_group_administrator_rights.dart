import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_administrator_rights.dart';

/// Sets default administrator rights for adding the bot to basic group and supergroup chats; for bots only
class SetDefaultGroupAdministratorRights extends TdFunction {
  String get tdType => 'setDefaultGroupAdministratorRights';
  String get tdReturnType => 'Ok';

  /// Default administrator rights for adding the bot to basic group and supergroup chats; may be null
  ChatAdministratorRights? default_group_administrator_rights;

  SetDefaultGroupAdministratorRights({
    super.extra,
    super.client_id,
    this.default_group_administrator_rights,
  });

  SetDefaultGroupAdministratorRights.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['default_group_administrator_rights'] != null) {
      default_group_administrator_rights = TdApiMap.fromMap(map['default_group_administrator_rights']) as ChatAdministratorRights;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'default_group_administrator_rights': default_group_administrator_rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}