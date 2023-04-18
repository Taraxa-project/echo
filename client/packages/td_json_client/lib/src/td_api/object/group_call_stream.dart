import 'package:td_json_client/src/td_api/td.dart';

/// Describes an available stream in a group call
class GroupCallStream extends TdObject {
  String get tdType => 'groupCallStream';

  /// Identifier of an audio/video channel
  int32? channel_id;

  /// Scale of segment durations in the stream. The duration is 1000/(2**scale) milliseconds
  int32? scale;

  /// Point in time when the stream currently ends; Unix timestamp in milliseconds
  int53? time_offset;

  GroupCallStream({
    super.extra,
    super.client_id,
    this.channel_id,
    this.scale,
    this.time_offset,
  });

  GroupCallStream.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    channel_id = map['channel_id'];
    scale = map['scale'];
    time_offset = map['time_offset'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'channel_id': channel_id?.toMap(skipNulls: skipNulls),
      'scale': scale?.toMap(skipNulls: skipNulls),
      'time_offset': time_offset?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
