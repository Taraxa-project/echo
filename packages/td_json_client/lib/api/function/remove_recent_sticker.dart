import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Removes a sticker from the list of recently used stickers 
class RemoveRecentSticker extends TdFunction {
  String get tdType => 'removeRecentSticker';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Pass true to remove the sticker from the list of stickers recently attached to photo or video files; pass false to remove the sticker from the list of recently sent stickers 
  Bool? is_attached;

  /// Sticker file to delete
  InputFile? sticker;

  RemoveRecentSticker({
    this.extra,
    this.client_id,
    this.is_attached,
    this.sticker,
  });

  RemoveRecentSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_attached = map['is_attached'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_attached': is_attached?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
