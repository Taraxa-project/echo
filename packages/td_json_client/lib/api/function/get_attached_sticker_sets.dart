import 'package:td_json_client/api/base.dart';


/// Returns a list of sticker sets attached to a file. Currently, only photos and videos can have attached sticker sets 
class GetAttachedStickerSets extends TdFunction {
  String get tdType => 'getAttachedStickerSets';
  String get tdReturnType => 'StickerSets';

  String? extra;
  int? client_id;

  /// File identifier
  int32? file_id;

  GetAttachedStickerSets({
    this.extra,
    this.client_id,
    this.file_id,
  });

  GetAttachedStickerSets.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
