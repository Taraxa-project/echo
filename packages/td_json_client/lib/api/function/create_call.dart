import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_protocol.dart';


/// Creates a new call 
class CreateCall extends TdFunction {
  String get tdType => 'createCall';
  String get tdReturnType => 'CallId';


  /// Identifier of the user to be called 
  int53? user_id;

  /// The call protocols supported by the application 
  CallProtocol? protocol;

  /// True, if a video call needs to be created
  Bool? is_video;

  CreateCall({
    super.extra,
    super.client_id,
    this.user_id,
    this.protocol,
    this.is_video,
  });

  CreateCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['protocol'] != null) {
      protocol = TdApiMap.fromMap(map['protocol']) as CallProtocol;
    }
    is_video = map['is_video'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'protocol': protocol?.toMap(skipNulls: skipNulls),
      'is_video': is_video?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
