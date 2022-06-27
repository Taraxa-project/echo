import 'package:td_json_client/api/base.dart';


/// Checks whether a name can be used for a new sticker set 
class CheckStickerSetName extends TdFunction {
  String get tdType => 'checkStickerSetName';
  String get tdReturnType => 'CheckStickerSetNameResult';

  String? extra;
  int? client_id;

  /// Name to be checked
  string? name;

  CheckStickerSetName({
    this.extra,
    this.client_id,
    this.name,
  });

  CheckStickerSetName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
