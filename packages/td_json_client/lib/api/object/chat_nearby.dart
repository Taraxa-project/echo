import 'package:td_json_client/api/base.dart';

class ChatNearby extends TdObject {
  String get tdType => 'chatNearby';

  String? extra;
  int? client_id;
  int53? chat_id;
  int32? distance;

  ChatNearby({
    this.extra,
    this.client_id,
    this.chat_id,
    this.distance,
  });

  ChatNearby.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    distance = map['distance'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'distance': distance?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
