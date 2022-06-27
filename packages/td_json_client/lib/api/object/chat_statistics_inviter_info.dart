import 'package:td_json_client/api/base.dart';

class ChatStatisticsInviterInfo extends TdObject {
  String get tdType => 'chatStatisticsInviterInfo';

  String? extra;
  int? client_id;
  int53? user_id;
  int32? added_member_count;

  ChatStatisticsInviterInfo({
    this.extra,
    this.client_id,
    this.user_id,
    this.added_member_count,
  });

  ChatStatisticsInviterInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    added_member_count = map['added_member_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'added_member_count': added_member_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
