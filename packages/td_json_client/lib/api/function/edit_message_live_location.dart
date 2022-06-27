import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/location.dart';

class EditMessageLiveLocation extends TdFunction {
  String get tdType => 'editMessageLiveLocation';
  String get tdReturnType => 'Message';

  string? extra;
  int? client_id;
  int53? chat_id;
  int53? message_id;
  ReplyMarkup? reply_markup;
  Location? location;
  int32? heading;
  int32? proximity_alert_radius;

  EditMessageLiveLocation({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.reply_markup,
    this.location,
    this.heading,
    this.proximity_alert_radius,
  });

  EditMessageLiveLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    location = TdApiMap.fromMap(map['location']) as Location;
    heading = map['heading'];
    proximity_alert_radius = map['proximity_alert_radius'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'heading': heading?.toMap(skipNulls: skipNulls),
      'proximity_alert_radius': proximity_alert_radius?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
