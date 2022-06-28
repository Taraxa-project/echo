import 'package:td_json_client/api/base.dart';


/// Deletes the account of the current user, deleting all information associated with the user from the server. The phone number of the account can be used to create a new account. Can be called before authorization when the current authorization state is authorizationStateWaitPassword 
class DeleteAccount extends TdFunction {
  String get tdType => 'deleteAccount';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The reason why the account was deleted; optional
  string? reason;

  DeleteAccount({
    this.extra,
    this.client_id,
    this.reason,
  });

  DeleteAccount.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reason = map['reason'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
