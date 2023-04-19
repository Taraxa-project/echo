import 'package:td_json_client/src/td_api/td.dart';

/// Contains a globally unique push receiver identifier, which can be used to identify which account has received a push notification
class PushReceiverId extends TdObject {
  String get tdType => 'pushReceiverId';

  /// The globally unique identifier of push notification subscription
  int64? id;

  PushReceiverId({
    super.extra,
    super.client_id,
    this.id,
  });

  PushReceiverId.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
