import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes a notification sound in MP3 format
class NotificationSound extends TdObject {
  String get tdType => 'notificationSound';

  String? extra;
  int? client_id;

  /// Unique identifier of the notification sound
  int64? id;

  /// Duration of the sound, in seconds
  int32? duration;

  /// Point in time (Unix timestamp) when the sound was created
  int32? date;

  /// Title of the notification sound
  string? title;

  /// Arbitrary data, defined while the sound was uploaded
  string? data;

  /// File containing the sound
  File? sound;

  NotificationSound({
    this.extra,
    this.client_id,
    this.id,
    this.duration,
    this.date,
    this.title,
    this.data,
    this.sound,
  });

  NotificationSound.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    duration = map['duration'];
    date = map['date'];
    title = map['title'];
    data = map['data'];
    sound = TdApiMap.fromMap(map['sound']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
      'sound': sound?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
