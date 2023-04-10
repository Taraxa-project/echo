import 'package:td_json_client/src/td_api/td.dart';

/// Returns up to 8 emoji statuses, which must be shown right after the default Premium Badge in the emoji status list
class GetThemedEmojiStatuses extends TdFunction {
  String get tdType => 'getThemedEmojiStatuses';
  String get tdReturnType => 'EmojiStatuses';

  GetThemedEmojiStatuses({
    super.extra,
    super.client_id,
  });

  GetThemedEmojiStatuses.fromMap(Map<String, dynamic> map) {
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
