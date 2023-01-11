import 'package:td_json_client/api/base.dart';


/// Returns default emoji statuses
class GetDefaultEmojiStatuses extends TdFunction {
  String get tdType => 'getDefaultEmojiStatuses';
  String get tdReturnType => 'EmojiStatuses';


  GetDefaultEmojiStatuses({
    super.extra,
    super.client_id,
  });

  GetDefaultEmojiStatuses.fromMap(Map<String, dynamic> map) {
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
