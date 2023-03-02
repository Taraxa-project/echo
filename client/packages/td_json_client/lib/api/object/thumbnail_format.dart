import 'package:td_json_client/api/base.dart';

/// Describes format of a thumbnail
abstract class ThumbnailFormat extends TdObject {
  ThumbnailFormat({super.extra, super.client_id});
}


/// The thumbnail is in JPEG format
class ThumbnailFormatJpeg extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatJpeg';


  ThumbnailFormatJpeg({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatJpeg.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in static GIF format. It will be used only for some bot inline results
class ThumbnailFormatGif extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatGif';


  ThumbnailFormatGif({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatGif.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in MPEG4 format. It will be used only for some animations and videos
class ThumbnailFormatMpeg4 extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatMpeg4';


  ThumbnailFormatMpeg4({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatMpeg4.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in PNG format. It will be used only for background patterns
class ThumbnailFormatPng extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatPng';


  ThumbnailFormatPng({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatPng.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in TGS format. It will be used only for TGS sticker sets
class ThumbnailFormatTgs extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatTgs';


  ThumbnailFormatTgs({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatTgs.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in WEBM format. It will be used only for WEBM sticker sets
class ThumbnailFormatWebm extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatWebm';


  ThumbnailFormatWebm({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatWebm.fromMap(Map<String, dynamic> map) {
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

/// The thumbnail is in WEBP format. It will be used only for some stickers
class ThumbnailFormatWebp extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatWebp';


  ThumbnailFormatWebp({
    super.extra,
    super.client_id,
  });

  ThumbnailFormatWebp.fromMap(Map<String, dynamic> map) {
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
