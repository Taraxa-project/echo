import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_sticker.dart';

class CreateNewStickerSet extends TdFunction {
  String get tdType => 'createNewStickerSet';
  String get tdReturnType => 'StickerSet';

  String? extra;
  int? client_id;
  int53? user_id;
  string? title;
  string? name;
  vector<InputSticker>? stickers;
  string? source;

  CreateNewStickerSet({
    this.extra,
    this.client_id,
    this.user_id,
    this.title,
    this.name,
    this.stickers,
    this.source,
  });

  CreateNewStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    title = map['title'];
    name = map['name'];
    if (map['stickers']) {
      stickers = [];
      for (var someValue in map['stickers']) {
        stickers?.add(TdApiMap.fromMap(someValue) as InputSticker);
      }
    }
    source = map['source'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'stickers': stickers?.toMap(skipNulls: skipNulls),
      'source': source?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
