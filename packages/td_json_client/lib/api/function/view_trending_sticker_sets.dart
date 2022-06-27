import 'package:td_json_client/api/base.dart';

class ViewTrendingStickerSets extends TdFunction {
  String get tdType => 'viewTrendingStickerSets';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  vector<int64>? sticker_set_ids;

  ViewTrendingStickerSets({
    this.extra,
    this.client_id,
    this.sticker_set_ids,
  });

  ViewTrendingStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker_set_ids']) {
      sticker_set_ids = [];
      for (var someValue in map['sticker_set_ids']) {
        sticker_set_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_set_ids': sticker_set_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
