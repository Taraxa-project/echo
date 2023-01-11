import 'package:td_json_client/api/base.dart';


/// Closes the TDLib instance, destroying all local data without a proper logout. The current user session will remain in the list of all active sessions. All local data will be destroyed.
/// After the destruction completes updateAuthorizationState with authorizationStateClosed will be sent. Can be called before authorization
class Destroy extends TdFunction {
  String get tdType => 'destroy';
  String get tdReturnType => 'Ok';


  Destroy({
    super.extra,
    super.client_id,
  });

  Destroy.fromMap(Map<String, dynamic> map) {
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
