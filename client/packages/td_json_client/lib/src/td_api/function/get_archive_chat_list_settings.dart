import 'package:td_json_client/src/td_api/td.dart';

/// Returns settings for automatic moving of chats to and from the Archive chat lists
class GetArchiveChatListSettings extends TdFunction {
  String get tdType => 'getArchiveChatListSettings';
  String get tdReturnType => 'ArchiveChatListSettings';

  GetArchiveChatListSettings({
    super.extra,
    super.client_id,
  });

  GetArchiveChatListSettings.fromMap(Map<String, dynamic> map) {
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
