import 'package:td_json_client/src/td_api/td.dart';

/// Returns list of chats with non-default notification settings for stories
class GetStoryNotificationSettingsExceptions extends TdFunction {
  String get tdType => 'getStoryNotificationSettingsExceptions';
  String get tdReturnType => 'Chats';

  GetStoryNotificationSettingsExceptions({
    super.extra,
    super.client_id,
  });

  GetStoryNotificationSettingsExceptions.fromMap(Map<String, dynamic> map) {
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
