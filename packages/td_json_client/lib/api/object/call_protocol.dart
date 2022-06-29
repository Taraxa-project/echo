import 'package:td_json_client/api/base.dart';


/// Specifies the supported call protocols
class CallProtocol extends TdObject {
  String get tdType => 'callProtocol';

  String? extra;
  int? client_id;

  /// True, if UDP peer-to-peer connections are supported
  Bool? udp_p2p;

  /// True, if connection through UDP reflectors is supported
  Bool? udp_reflector;

  /// The minimum supported API layer; use 65
  int32? min_layer;

  /// The maximum supported API layer; use 65
  int32? max_layer;

  /// List of supported tgcalls versions
  vector<string>? library_versions;

  CallProtocol({
    this.extra,
    this.client_id,
    this.udp_p2p,
    this.udp_reflector,
    this.min_layer,
    this.max_layer,
    this.library_versions,
  });

  CallProtocol.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    udp_p2p = map['udp_p2p'];
    udp_reflector = map['udp_reflector'];
    min_layer = map['min_layer'];
    max_layer = map['max_layer'];
    if (map['library_versions'] != null) {
      library_versions = [];
      for (var someValue in map['library_versions']) {
        library_versions?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'udp_p2p': udp_p2p?.toMap(skipNulls: skipNulls),
      'udp_reflector': udp_reflector?.toMap(skipNulls: skipNulls),
      'min_layer': min_layer?.toMap(skipNulls: skipNulls),
      'max_layer': max_layer?.toMap(skipNulls: skipNulls),
      'library_versions': library_versions?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
