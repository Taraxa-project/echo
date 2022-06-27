import 'package:td_json_client/api/base.dart';

class SetSupergroupStickerSet extends TdFunction {
  String get tdType => 'setSupergroupStickerSet';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int53? supergroup_id;
  int64? sticker_set_id;

  SetSupergroupStickerSet({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.sticker_set_id,
  });

  SetSupergroupStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    sticker_set_id = map['sticker_set_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'sticker_set_id': sticker_set_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
