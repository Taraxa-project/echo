import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/archive_chat_list_settings.dart';

/// Changes settings for automatic moving of chats to and from the Archive chat lists
class SetArchiveChatListSettings extends TdFunction {
  String get tdType => 'setArchiveChatListSettings';
  String get tdReturnType => 'Ok';

  /// New settings
  ArchiveChatListSettings? settings;

  SetArchiveChatListSettings({
    super.extra,
    super.client_id,
    this.settings,
  });

  SetArchiveChatListSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['settings'] != null) {
      settings = TdApiMap.fromMap(map['settings']) as ArchiveChatListSettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'settings': settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
