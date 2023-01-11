import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_state.dart';

/// Describes a call
class Call extends TdObject {
  String get tdType => 'call';

  /// Call identifier, not persistent
  int32? id;

  /// Peer user identifier
  int53? user_id;

  /// True, if the call is outgoing
  Bool? is_outgoing;

  /// True, if the call is a video call
  Bool? is_video;

  /// Call state
  CallState? state;

  Call({
    super.extra,
    super.client_id,
    this.id,
    this.user_id,
    this.is_outgoing,
    this.is_video,
    this.state,
  });

  Call.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    user_id = map['user_id'];
    is_outgoing = map['is_outgoing'];
    is_video = map['is_video'];
    if (map['state'] != null) {
      state = TdApiMap.fromMap(map['state']) as CallState;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'is_outgoing': is_outgoing?.toMap(skipNulls: skipNulls),
      'is_video': is_video?.toMap(skipNulls: skipNulls),
      'state': state?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
