import 'package:td_json_client/api/base.dart';

/// Represents the type of a file
abstract class FileType extends TdObject {}


/// The data is not a file
class FileTypeNone extends FileType {
  String get tdType => 'fileTypeNone';

  String? extra;
  int? client_id;

  FileTypeNone({
    this.extra,
    this.client_id,
  });

  FileTypeNone.fromMap(Map<String, dynamic> map) {
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

/// The file is an animation
class FileTypeAnimation extends FileType {
  String get tdType => 'fileTypeAnimation';

  String? extra;
  int? client_id;

  FileTypeAnimation({
    this.extra,
    this.client_id,
  });

  FileTypeAnimation.fromMap(Map<String, dynamic> map) {
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

/// The file is an audio file
class FileTypeAudio extends FileType {
  String get tdType => 'fileTypeAudio';

  String? extra;
  int? client_id;

  FileTypeAudio({
    this.extra,
    this.client_id,
  });

  FileTypeAudio.fromMap(Map<String, dynamic> map) {
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

/// The file is a document
class FileTypeDocument extends FileType {
  String get tdType => 'fileTypeDocument';

  String? extra;
  int? client_id;

  FileTypeDocument({
    this.extra,
    this.client_id,
  });

  FileTypeDocument.fromMap(Map<String, dynamic> map) {
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

/// The file is a photo
class FileTypePhoto extends FileType {
  String get tdType => 'fileTypePhoto';

  String? extra;
  int? client_id;

  FileTypePhoto({
    this.extra,
    this.client_id,
  });

  FileTypePhoto.fromMap(Map<String, dynamic> map) {
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

/// The file is a profile photo
class FileTypeProfilePhoto extends FileType {
  String get tdType => 'fileTypeProfilePhoto';

  String? extra;
  int? client_id;

  FileTypeProfilePhoto({
    this.extra,
    this.client_id,
  });

  FileTypeProfilePhoto.fromMap(Map<String, dynamic> map) {
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

/// The file was sent to a secret chat (the file type is not known to the server)
class FileTypeSecret extends FileType {
  String get tdType => 'fileTypeSecret';

  String? extra;
  int? client_id;

  FileTypeSecret({
    this.extra,
    this.client_id,
  });

  FileTypeSecret.fromMap(Map<String, dynamic> map) {
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

/// The file is a thumbnail of a file from a secret chat
class FileTypeSecretThumbnail extends FileType {
  String get tdType => 'fileTypeSecretThumbnail';

  String? extra;
  int? client_id;

  FileTypeSecretThumbnail({
    this.extra,
    this.client_id,
  });

  FileTypeSecretThumbnail.fromMap(Map<String, dynamic> map) {
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

/// The file is a file from Secure storage used for storing Telegram Passport files
class FileTypeSecure extends FileType {
  String get tdType => 'fileTypeSecure';

  String? extra;
  int? client_id;

  FileTypeSecure({
    this.extra,
    this.client_id,
  });

  FileTypeSecure.fromMap(Map<String, dynamic> map) {
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

/// The file is a sticker
class FileTypeSticker extends FileType {
  String get tdType => 'fileTypeSticker';

  String? extra;
  int? client_id;

  FileTypeSticker({
    this.extra,
    this.client_id,
  });

  FileTypeSticker.fromMap(Map<String, dynamic> map) {
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

/// The file is a thumbnail of another file
class FileTypeThumbnail extends FileType {
  String get tdType => 'fileTypeThumbnail';

  String? extra;
  int? client_id;

  FileTypeThumbnail({
    this.extra,
    this.client_id,
  });

  FileTypeThumbnail.fromMap(Map<String, dynamic> map) {
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

/// The file type is not yet known
class FileTypeUnknown extends FileType {
  String get tdType => 'fileTypeUnknown';

  String? extra;
  int? client_id;

  FileTypeUnknown({
    this.extra,
    this.client_id,
  });

  FileTypeUnknown.fromMap(Map<String, dynamic> map) {
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

/// The file is a video
class FileTypeVideo extends FileType {
  String get tdType => 'fileTypeVideo';

  String? extra;
  int? client_id;

  FileTypeVideo({
    this.extra,
    this.client_id,
  });

  FileTypeVideo.fromMap(Map<String, dynamic> map) {
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

/// The file is a video note
class FileTypeVideoNote extends FileType {
  String get tdType => 'fileTypeVideoNote';

  String? extra;
  int? client_id;

  FileTypeVideoNote({
    this.extra,
    this.client_id,
  });

  FileTypeVideoNote.fromMap(Map<String, dynamic> map) {
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

/// The file is a voice note
class FileTypeVoiceNote extends FileType {
  String get tdType => 'fileTypeVoiceNote';

  String? extra;
  int? client_id;

  FileTypeVoiceNote({
    this.extra,
    this.client_id,
  });

  FileTypeVoiceNote.fromMap(Map<String, dynamic> map) {
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

/// The file is a wallpaper or a background pattern
class FileTypeWallpaper extends FileType {
  String get tdType => 'fileTypeWallpaper';

  String? extra;
  int? client_id;

  FileTypeWallpaper({
    this.extra,
    this.client_id,
  });

  FileTypeWallpaper.fromMap(Map<String, dynamic> map) {
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
