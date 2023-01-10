import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/authentication_code_type.dart';


/// Information about the authentication code that was sent 
class AuthenticationCodeInfo extends TdObject {
  String get tdType => 'authenticationCodeInfo';


  /// A phone number that is being authenticated 
  string? phone_number;

  /// The way the code was sent to the user 
  AuthenticationCodeType? type;

  /// The way the next code will be sent to the user; may be null 
  AuthenticationCodeType? next_type;

  /// Timeout before the code can be re-sent, in seconds
  int32? timeout;

  AuthenticationCodeInfo({
    super.extra,
    super.client_id,
    this.phone_number,
    this.type,
    this.next_type,
    this.timeout,
  });

  AuthenticationCodeInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as AuthenticationCodeType;
    }
    if (map['next_type'] != null) {
      next_type = TdApiMap.fromMap(map['next_type']) as AuthenticationCodeType;
    }
    timeout = map['timeout'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'next_type': next_type?.toMap(skipNulls: skipNulls),
      'timeout': timeout?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
