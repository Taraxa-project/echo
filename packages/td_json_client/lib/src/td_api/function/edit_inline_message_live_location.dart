import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';
import 'package:td_json_client/src/td_api/object/location.dart';

/// Edits the content of a live location in an inline message sent via a bot; for bots only
class EditInlineMessageLiveLocation extends TdFunction {
  String get tdType => 'editInlineMessageLiveLocation';
  String get tdReturnType => 'Ok';

  /// Inline message identifier
  string? inline_message_id;

  /// The new message reply markup; pass null if none
  ReplyMarkup? reply_markup;

  /// New location content of the message; pass null to stop sharing the live location
  Location? location;

  /// The new direction in which the location moves, in degrees; 1-360. Pass 0 if unknown
  int32? heading;

  /// The new maximum distance for proximity alerts, in meters (0-100000). Pass 0 if the notification is disabled
  int32? proximity_alert_radius;

  EditInlineMessageLiveLocation({
    super.extra,
    super.client_id,
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
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
