import 'package:td_json_client/src/td_api/td.dart';

/// Sets a sticker set title; for bots only
class SetStickerSetTitle extends TdFunction {
  String get tdType => 'setStickerSetTitle';
  String get tdReturnType => 'Ok';

  /// Sticker set name
  string? name;

  /// New sticker set title
  string? title;

  SetStickerSetTitle({
    super.extra,
    super.client_id,
    this.name,
    this.title,
  });

  SetStickerSetTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
