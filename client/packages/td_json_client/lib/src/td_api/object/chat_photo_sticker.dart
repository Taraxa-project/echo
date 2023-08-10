import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_photo_sticker_type.dart';
import 'package:td_json_client/src/td_api/object/background_fill.dart';

/// Information about the sticker, which was used to create the chat photo. The sticker is shown at the center of the photo and occupies at most 67% of it
class ChatPhotoSticker extends TdObject {
  String get tdType => 'chatPhotoSticker';

  /// Type of the sticker
  ChatPhotoStickerType? type;

  /// The fill to be used as background for the sticker; rotation angle in backgroundFillGradient isn't supported
  BackgroundFill? background_fill;

  ChatPhotoSticker({
    super.extra,
    super.client_id,
    this.type,
    this.background_fill,
  });

  ChatPhotoSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ChatPhotoStickerType;
    }
    if (map['background_fill'] != null) {
      background_fill = TdApiMap.fromMap(map['background_fill']) as BackgroundFill;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'background_fill': background_fill?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
