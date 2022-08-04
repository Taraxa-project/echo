import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_sticker.dart';


/// Creates a new sticker set. Returns the newly created sticker set
class CreateNewStickerSet extends TdFunction {
  String get tdType => 'createNewStickerSet';
  String get tdReturnType => 'StickerSet';


  /// Sticker set owner; ignored for regular users
  int53? user_id;

  /// Sticker set title; 1-64 characters
  string? title;

  /// Sticker set name. Can contain only English letters, digits and underscores. Must end with *"_by_<bot username>"* (*<bot_username>* is case insensitive) for bots; 1-64 characters
  string? name;

  /// List of stickers to be added to the set; must be non-empty. All stickers must have the same format. For TGS stickers, uploadStickerFile must be used before the sticker is shown
  vector<InputSticker>? stickers;

  /// Source of the sticker set; may be empty if unknown
  string? source;

  CreateNewStickerSet({
    super.extra,
    super.client_id,
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
    if (map['stickers'] != null) {
      stickers = [];
      for (var someValue in map['stickers']) {
        if (someValue != null) {
          stickers?.add(TdApiMap.fromMap(someValue) as InputSticker);
        }
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
