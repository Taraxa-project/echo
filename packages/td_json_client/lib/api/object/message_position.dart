import 'package:td_json_client/api/base.dart';


/// Contains information about a message in a specific position 
class MessagePosition extends TdObject {
  String get tdType => 'messagePosition';


  /// 0-based message position in the full list of suitable messages 
  int32? position;

  /// Message identifier 
  int53? message_id;

  /// Point in time (Unix timestamp) when the message was sent
  int32? date;

  MessagePosition({
    super.extra,
    super.client_id,
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
