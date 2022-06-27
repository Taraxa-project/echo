import 'package:td_json_client/api/base.dart';

class GroupCallStream extends TdObject {
  String get tdType => 'groupCallStream';

  String? extra;
  int? client_id;
  int32? channel_id;
  int32? scale;
  int53? time_offset;

  GroupCallStream({
    this.extra,
    this.client_id,
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
