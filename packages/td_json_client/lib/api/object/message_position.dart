import 'package:td_json_client/api/base.dart';

class MessagePosition extends TdObject {
  String get tdType => 'messagePosition';

  String? extra;
  int? client_id;
  int32? position;
  int53? message_id;
  int32? date;

  MessagePosition({
    this.extra,
    this.client_id,
    this.position,
    this.message_id,
    this.date,
  });

  MessagePosition.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    position = map['position'];
    message_id = map['message_id'];
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'position': position?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
