import 'package:td_json_client/src/td_api/td.dart';

/// Returns a list of recently inactive supergroups and channels. Can be used when user reaches limit on the number of joined supergroups and channels and receives CHANNELS_TOO_MUCH error. Also, the limit can be increased with Telegram Premium
class GetInactiveSupergroupChats extends TdFunction {
  String get tdType => 'getInactiveSupergroupChats';
  String get tdReturnType => 'Chats';

  GetInactiveSupergroupChats({
    super.extra,
    super.client_id,
  });

  GetInactiveSupergroupChats.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
