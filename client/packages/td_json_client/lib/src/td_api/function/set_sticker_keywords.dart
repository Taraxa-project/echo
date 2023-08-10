import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// Changes the list of keywords of a sticker; for bots only. The sticker must belong to a regular or custom emoji sticker set created by the bot
class SetStickerKeywords extends TdFunction {
  String get tdType => 'setStickerKeywords';
  String get tdReturnType => 'Ok';

  /// Sticker
  InputFile? sticker;

  /// List of up to 20 keywords with total length up to 64 characters, which can be used to find the sticker
  vector<string>? keywords;

  SetStickerKeywords({
    super.extra,
    super.client_id,
    this.sticker,
    this.keywords,
  });

  SetStickerKeywords.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    if (map['keywords'] != null) {
      keywords = [];
      for (var someValue in map['keywords']) {
        keywords?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'keywords': keywords?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
