import 'package:td_json_client/src/td_api/td.dart';

/// Describes a custom emoji to be shown instead of the Telegram Premium badge
class EmojiStatus extends TdObject {
  String get tdType => 'emojiStatus';

  /// Identifier of the custom emoji in stickerFormatTgs format
  int64? custom_emoji_id;

  /// Point in time (Unix timestamp) when the status will expire; 0 if never
  int32? expiration_date;

  EmojiStatus({
    super.extra,
    super.client_id,
    this.custom_emoji_id,
    this.expiration_date,
  });

  EmojiStatus.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    custom_emoji_id = map['custom_emoji_id'];
    expiration_date = map['expiration_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'custom_emoji_id': custom_emoji_id?.toMap(skipNulls: skipNulls),
      'expiration_date': expiration_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
