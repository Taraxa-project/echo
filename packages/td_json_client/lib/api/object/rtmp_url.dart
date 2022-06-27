import 'package:td_json_client/api/base.dart';


/// Represents an RTMP url 
class RtmpUrl extends TdObject {
  String get tdType => 'rtmpUrl';

  String? extra;
  int? client_id;

  /// The URL 
  string? url;

  /// Stream key
  string? stream_key;

  RtmpUrl({
    this.extra,
    this.client_id,
    this.url,
    this.stream_key,
  });

  RtmpUrl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    stream_key = map['stream_key'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'stream_key': stream_key?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
