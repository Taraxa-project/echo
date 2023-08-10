import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/emoji_status.dart';

/// Changes the emoji status of the current user; for Telegram Premium users only
class SetEmojiStatus extends TdFunction {
  String get tdType => 'setEmojiStatus';
  String get tdReturnType => 'Ok';

  /// New emoji status; pass null to switch to the default badge
  EmojiStatus? emoji_status;

  SetEmojiStatus({
    super.extra,
    super.client_id,
    this.emoji_status,
  });

  SetEmojiStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['emoji_status'] != null) {
      emoji_status = TdApiMap.fromMap(map['emoji_status']) as EmojiStatus;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji_status': emoji_status?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
