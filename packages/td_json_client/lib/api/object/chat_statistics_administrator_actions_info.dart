import 'package:td_json_client/api/base.dart';

class ChatStatisticsAdministratorActionsInfo extends TdObject {
  String get tdType => 'chatStatisticsAdministratorActionsInfo';

  String? extra;
  int? client_id;
  int53? user_id;
  int32? deleted_message_count;
  int32? banned_user_count;
  int32? restricted_user_count;

  ChatStatisticsAdministratorActionsInfo({
    this.extra,
    this.client_id,
    this.user_id,
    this.deleted_message_count,
    this.banned_user_count,
    this.restricted_user_count,
  });

  ChatStatisticsAdministratorActionsInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    deleted_message_count = map['deleted_message_count'];
    banned_user_count = map['banned_user_count'];
    restricted_user_count = map['restricted_user_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'deleted_message_count': deleted_message_count?.toMap(skipNulls: skipNulls),
      'banned_user_count': banned_user_count?.toMap(skipNulls: skipNulls),
      'restricted_user_count': restricted_user_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
