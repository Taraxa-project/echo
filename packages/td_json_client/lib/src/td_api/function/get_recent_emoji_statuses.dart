import 'package:td_json_client/src/td_api/td.dart';

/// Returns recent emoji statuses
class GetRecentEmojiStatuses extends TdFunction {
  String get tdType => 'getRecentEmojiStatuses';
  String get tdReturnType => 'EmojiStatuses';

  GetRecentEmojiStatuses({
    super.extra,
    super.client_id,
  });

  GetRecentEmojiStatuses.fromMap(Map<String, dynamic> map) {
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
