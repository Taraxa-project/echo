import 'package:td_json_client/src/td_api/td.dart';

/// Installs/uninstalls or activates/archives a sticker set
class ChangeStickerSet extends TdFunction {
  String get tdType => 'changeStickerSet';
  String get tdReturnType => 'Ok';

  /// Identifier of the sticker set
  int64? set_id;

  /// The new value of is_installed
  Bool? is_installed;

  /// The new value of is_archived. A sticker set can't be installed and archived simultaneously
  Bool? is_archived;

  ChangeStickerSet({
    super.extra,
    super.client_id,
    this.set_id,
    this.is_installed,
    this.is_archived,
  });

  ChangeStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    set_id = map['set_id'];
    is_installed = map['is_installed'];
    is_archived = map['is_archived'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'set_id': set_id?.toMap(skipNulls: skipNulls),
      'is_installed': is_installed?.toMap(skipNulls: skipNulls),
      'is_archived': is_archived?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
