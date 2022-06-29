import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_protocol.dart';


/// Accepts an incoming call 
class AcceptCall extends TdFunction {
  String get tdType => 'acceptCall';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Call identifier 
  int32? call_id;

  /// The call protocols supported by the application
  CallProtocol? protocol;

  AcceptCall({
    this.extra,
    this.client_id,
    this.call_id,
    this.protocol,
  });

  AcceptCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    call_id = map['call_id'];
    if (map['protocol'] != null) {
      protocol = TdApiMap.fromMap(map['protocol']) as CallProtocol;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'call_id': call_id?.toMap(skipNulls: skipNulls),
      'protocol': protocol?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
