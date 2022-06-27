import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';

class SetDefaultGroupAdministratorRights extends TdFunction {
  String get tdType => 'setDefaultGroupAdministratorRights';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  ChatAdministratorRights? default_group_administrator_rights;

  SetDefaultGroupAdministratorRights({
    this.extra,
    this.client_id,
    this.default_group_administrator_rights,
  });

  SetDefaultGroupAdministratorRights.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    default_group_administrator_rights = TdApiMap.fromMap(map['default_group_administrator_rights']) as ChatAdministratorRights;
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
