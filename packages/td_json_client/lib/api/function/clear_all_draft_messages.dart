import 'package:td_json_client/api/base.dart';


/// Clears draft messages in all chats 
class ClearAllDraftMessages extends TdFunction {
  String get tdType => 'clearAllDraftMessages';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// If true, local draft messages in secret chats will not be cleared
  Bool? exclude_secret_chats;

  ClearAllDraftMessages({
    this.extra,
    this.client_id,
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
