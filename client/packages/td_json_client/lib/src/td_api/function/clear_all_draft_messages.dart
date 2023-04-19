import 'package:td_json_client/src/td_api/td.dart';

/// Clears message drafts in all chats
class ClearAllDraftMessages extends TdFunction {
  String get tdType => 'clearAllDraftMessages';
  String get tdReturnType => 'Ok';

  /// Pass true to keep local message drafts in secret chats
  Bool? exclude_secret_chats;

  ClearAllDraftMessages({
    super.extra,
    super.client_id,
    this.exclude_secret_chats,
  });

  ClearAllDraftMessages.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    exclude_secret_chats = map['exclude_secret_chats'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'exclude_secret_chats': exclude_secret_chats?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
