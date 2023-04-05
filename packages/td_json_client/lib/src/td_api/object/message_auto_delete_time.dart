import 'package:td_json_client/src/td_api/td.dart';

/// Contains default auto-delete timer setting for new chats
class MessageAutoDeleteTime extends TdObject {
  String get tdType => 'messageAutoDeleteTime';

  /// Message auto-delete time, in seconds. If 0, then messages aren't deleted automatically
  int32? time;

  MessageAutoDeleteTime({
    super.extra,
    super.client_id,
    this.time,
  });

  MessageAutoDeleteTime.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    time = map['time'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'time': time?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
