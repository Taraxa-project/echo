import 'package:td_json_client/src/td_api/td.dart';

/// Deletes all call messages
class DeleteAllCallMessages extends TdFunction {
  String get tdType => 'deleteAllCallMessages';
  String get tdReturnType => 'Ok';

  /// Pass true to delete the messages for all users
  Bool? revoke;

  DeleteAllCallMessages({
    super.extra,
    super.client_id,
    this.revoke,
  });

  DeleteAllCallMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    revoke = map['revoke'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'revoke': revoke?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
