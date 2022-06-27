import 'package:td_json_client/api/base.dart';

class DiscardCall extends TdFunction {
  String get tdType => 'discardCall';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? call_id;
  Bool? is_disconnected;
  int32? duration;
  Bool? is_video;
  int64? connection_id;

  DiscardCall({
    this.extra,
    this.client_id,
    this.call_id,
    this.is_disconnected,
    this.duration,
    this.is_video,
    this.connection_id,
  });

  DiscardCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    is_disconnected = map['is_disconnected'];
    duration = map['duration'];
    is_video = map['is_video'];
    connection_id = map['connection_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'is_disconnected': is_disconnected?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'is_video': is_video?.toMap(skipNulls: skipNulls),
      'connection_id': connection_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
