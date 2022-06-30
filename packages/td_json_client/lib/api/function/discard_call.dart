import 'package:td_json_client/api/base.dart';


/// Discards a call 
class DiscardCall extends TdFunction {
  String get tdType => 'discardCall';
  String get tdReturnType => 'Ok';


  /// Call identifier 
  int32? call_id;

  /// True, if the user was disconnected 
  Bool? is_disconnected;

  /// The call duration, in seconds 
  int32? duration;

  /// True, if the call was a video call 
  Bool? is_video;

  /// Identifier of the connection used during the call
  int64? connection_id;

  DiscardCall({
    super.extra,
    super.client_id,
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
