import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/device_token.dart';


/// Registers the currently used device for receiving push notifications. Returns a globally unique identifier of the push notification subscription 
class RegisterDevice extends TdFunction {
  String get tdType => 'registerDevice';
  String get tdReturnType => 'PushReceiverId';


  /// Device token 
  DeviceToken? device_token;

  /// List of user identifiers of other users currently using the application
  vector<int53>? other_user_ids;

  RegisterDevice({
    super.extra,
    super.client_id,
    this.device_token,
    this.other_user_ids,
  });

  RegisterDevice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['device_token'] != null) {
      device_token = TdApiMap.fromMap(map['device_token']) as DeviceToken;
    }
    if (map['other_user_ids'] != null) {
      other_user_ids = [];
      for (var someValue in map['other_user_ids']) {
        other_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'device_token': device_token?.toMap(skipNulls: skipNulls),
      'other_user_ids': other_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
