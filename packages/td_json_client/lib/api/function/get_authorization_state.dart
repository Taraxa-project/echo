import 'package:td_json_client/api/base.dart';


/// Returns the current authorization state; this is an offline request. For informational purposes only. Use updateAuthorizationState instead to maintain the current authorization state. Can be called before initialization
class GetAuthorizationState extends TdFunction {
  String get tdType => 'getAuthorizationState';
  String get tdReturnType => 'AuthorizationState';

  String? extra;
  int? client_id;

  GetAuthorizationState({
    this.extra,
    this.client_id,
  });

  GetAuthorizationState.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
