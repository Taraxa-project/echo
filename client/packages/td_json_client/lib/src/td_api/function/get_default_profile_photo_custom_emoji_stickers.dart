import 'package:td_json_client/src/td_api/td.dart';

/// Returns default list of custom emoji stickers for placing on a profile photo
class GetDefaultProfilePhotoCustomEmojiStickers extends TdFunction {
  String get tdType => 'getDefaultProfilePhotoCustomEmojiStickers';
  String get tdReturnType => 'Stickers';

  GetDefaultProfilePhotoCustomEmojiStickers({
    super.extra,
    super.client_id,
  });

  GetDefaultProfilePhotoCustomEmojiStickers.fromMap(Map<String, dynamic> map) {
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
