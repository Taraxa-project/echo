import 'package:td_json_client/api/base.dart';

abstract class ThumbnailFormat extends TdObject {}

class ThumbnailFormatJpeg extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatJpeg';

  string? extra;
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
class ThumbnailFormatGif extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatGif';

  string? extra;
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
class ThumbnailFormatMpeg4 extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatMpeg4';

  string? extra;
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
class ThumbnailFormatPng extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatPng';

  string? extra;
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
class ThumbnailFormatTgs extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatTgs';

  string? extra;
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
class ThumbnailFormatWebm extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatWebm';

  string? extra;
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
class ThumbnailFormatWebp extends ThumbnailFormat {
  String get tdType => 'thumbnailFormatWebp';

  string? extra;
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
