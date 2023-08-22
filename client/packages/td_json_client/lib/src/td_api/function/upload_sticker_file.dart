import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/sticker_format.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// Uploads a file with a sticker; returns the uploaded file
class UploadStickerFile extends TdFunction {
  String get tdType => 'uploadStickerFile';
  String get tdReturnType => 'File';

  /// Sticker file owner; ignored for regular users
  int53? user_id;

  /// Sticker format
  StickerFormat? sticker_format;

  /// File file to upload; must fit in a 512x512 square. For WEBP stickers the file must be in WEBP or PNG format, which will be converted to WEBP server-side.
  /// See https://core.telegram.org/animated_stickers#technical-requirements for technical requirements
  InputFile? sticker;

  UploadStickerFile({
    super.extra,
    super.client_id,
    this.user_id,
    this.sticker_format,
    this.sticker,
  });

  UploadStickerFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['sticker_format'] != null) {
      sticker_format = TdApiMap.fromMap(map['sticker_format']) as StickerFormat;
    }
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'sticker_format': sticker_format?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
