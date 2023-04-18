import 'package:td_json_client/src/td_api/td.dart';

/// Shares the phone number of the current user with a mutual contact. Supposed to be called when the user clicks on chatActionBarSharePhoneNumber
class SharePhoneNumber extends TdFunction {
  String get tdType => 'sharePhoneNumber';
  String get tdReturnType => 'Ok';

  /// Identifier of the user with whom to share the phone number. The user must be a mutual contact
  int53? user_id;

  SharePhoneNumber({
    super.extra,
    super.client_id,
    this.user_id,
  });

  SharePhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
