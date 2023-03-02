import 'package:td_json_client/api/base.dart';

/// Describes format of a sticker
abstract class StickerFormat extends TdObject {
  StickerFormat({super.extra, super.client_id});
}


/// The sticker is an image in WEBP format
class StickerFormatWebp extends StickerFormat {
  String get tdType => 'stickerFormatWebp';


  StickerFormatWebp({
    super.extra,
    super.client_id,
  });

  StickerFormatWebp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is an animation in TGS format
class StickerFormatTgs extends StickerFormat {
  String get tdType => 'stickerFormatTgs';


  StickerFormatTgs({
    super.extra,
    super.client_id,
  });

  StickerFormatTgs.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sticker is a video in WEBM format
class StickerFormatWebm extends StickerFormat {
  String get tdType => 'stickerFormatWebm';


  StickerFormatWebm({
    super.extra,
    super.client_id,
  });

  StickerFormatWebm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
