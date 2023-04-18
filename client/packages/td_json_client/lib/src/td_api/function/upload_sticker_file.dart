import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_sticker.dart';

/// Uploads a file with a sticker; returns the uploaded file
class UploadStickerFile extends TdFunction {
  String get tdType => 'uploadStickerFile';
  String get tdReturnType => 'File';

  /// Sticker file owner; ignored for regular users
  int53? user_id;

  /// Sticker file to upload
  InputSticker? sticker;

  UploadStickerFile({
    super.extra,
    super.client_id,
    this.user_id,
    this.sticker,
  });

  UploadStickerFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputSticker;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
