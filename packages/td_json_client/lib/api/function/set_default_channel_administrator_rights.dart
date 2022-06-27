import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';

class SetDefaultChannelAdministratorRights extends TdFunction {
  String get tdType => 'setDefaultChannelAdministratorRights';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  ChatAdministratorRights? default_channel_administrator_rights;

  SetDefaultChannelAdministratorRights({
    this.extra,
    this.client_id,
    this.default_channel_administrator_rights,
  });

  SetDefaultChannelAdministratorRights.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    default_channel_administrator_rights = TdApiMap.fromMap(map['default_channel_administrator_rights']) as ChatAdministratorRights;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'default_channel_administrator_rights': default_channel_administrator_rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
