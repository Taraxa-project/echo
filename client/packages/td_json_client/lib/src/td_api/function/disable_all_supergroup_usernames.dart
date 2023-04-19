import 'package:td_json_client/src/td_api/td.dart';

/// Disables all active non-editable usernames of a supergroup or channel, requires owner privileges in the supergroup or channel
class DisableAllSupergroupUsernames extends TdFunction {
  String get tdType => 'disableAllSupergroupUsernames';
  String get tdReturnType => 'Ok';

  /// Identifier of the supergroup or channel
  int53? supergroup_id;

  DisableAllSupergroupUsernames({
    super.extra,
    super.client_id,
    this.supergroup_id,
  });

  DisableAllSupergroupUsernames.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
