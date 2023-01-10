import 'package:td_json_client/api/base.dart';


/// Starts screen sharing in a joined group call. Returns join response payload for tgcalls
class StartGroupCallScreenSharing extends TdFunction {
  String get tdType => 'startGroupCallScreenSharing';
  String get tdReturnType => 'Text';


  /// Group call identifier
  int32? group_call_id;

  /// Screen sharing audio channel synchronization source identifier; received from tgcalls
  int32? audio_source_id;

  /// Group call join payload; received from tgcalls
  string? payload;

  StartGroupCallScreenSharing({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.audio_source_id,
    this.payload,
  });

  StartGroupCallScreenSharing.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    audio_source_id = map['audio_source_id'];
    payload = map['payload'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'audio_source_id': audio_source_id?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
