import 'package:td_json_client/src/td_api/td.dart';

/// Adds server-provided application changelog as messages to the chat 777000 (Telegram) or as a stories; for official applications only. Returns a 404 error if nothing changed
class AddApplicationChangelog extends TdFunction {
  String get tdType => 'addApplicationChangelog';
  String get tdReturnType => 'Ok';

  /// The previous application version
  string? previous_application_version;

  AddApplicationChangelog({
    super.extra,
    super.client_id,
    this.previous_application_version,
  });

  AddApplicationChangelog.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    previous_application_version = map['previous_application_version'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'previous_application_version': previous_application_version?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
