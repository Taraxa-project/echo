import 'package:td_json_client/api/base.dart';

/// Describes format of a thumbnail
abstract class ThumbnailFormat extends TdObject {}


/// The thumbnail is in JPEG format
class ThumbnailFormatJpeg extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatJpeg';

  String? extra;
  int? client_id;

  ThumbnailFormatJpeg({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatGif({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatMpeg4({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatPng({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatTgs({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatWebm({
    this.extra,
    this.client_id,
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

  String? extra;
  int? client_id;

  ThumbnailFormatWebp({
    this.extra,
    this.client_id,
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
