import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/location.dart';

class EditInlineMessageLiveLocation extends TdFunction {
  String get tdType => 'editInlineMessageLiveLocation';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? inline_message_id;
  ReplyMarkup? reply_markup;
  Location? location;
  int32? heading;
  int32? proximity_alert_radius;

  EditInlineMessageLiveLocation({
    this.extra,
    this.client_id,
    this.inline_message_id,
    this.reply_markup,
    this.location,
    this.heading,
    this.proximity_alert_radius,
  });

  EditInlineMessageLiveLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
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
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
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
