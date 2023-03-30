import 'package:td_json_client/src/td_api/td.dart';

/// Contains the description of an error in a Telegram Passport element; for bots only
abstract class InputPassportElementErrorSource extends TdObject {
  InputPassportElementErrorSource({super.extra, super.client_id});
}

/// The element contains an error in an unspecified place. The error will be considered resolved when new data is added
class InputPassportElementErrorSourceUnspecified
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceUnspecified';

  /// Current hash of the entire element
  bytes? element_hash;

  InputPassportElementErrorSourceUnspecified({
    super.extra,
    super.client_id,
    this.element_hash,
  });

  InputPassportElementErrorSourceUnspecified.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    element_hash = map['element_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'element_hash': element_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A data field contains an error. The error is considered resolved when the field's value changes
class InputPassportElementErrorSourceDataField
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceDataField';

  /// Field name
  string? field_name;

  /// Current data hash
  bytes? data_hash;

  InputPassportElementErrorSourceDataField({
    super.extra,
    super.client_id,
    this.field_name,
    this.data_hash,
  });

  InputPassportElementErrorSourceDataField.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    field_name = map['field_name'];
    data_hash = map['data_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'field_name': field_name?.toMap(skipNulls: skipNulls),
      'data_hash': data_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The front side of the document contains an error. The error is considered resolved when the file with the front side of the document changes
class InputPassportElementErrorSourceFrontSide
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFrontSide';

  /// Current hash of the file containing the front side
  bytes? file_hash;

  InputPassportElementErrorSourceFrontSide({
    super.extra,
    super.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceFrontSide.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_hash = map['file_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hash': file_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The reverse side of the document contains an error. The error is considered resolved when the file with the reverse side of the document changes
class InputPassportElementErrorSourceReverseSide
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceReverseSide';

  /// Current hash of the file containing the reverse side
  bytes? file_hash;

  InputPassportElementErrorSourceReverseSide({
    super.extra,
    super.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceReverseSide.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_hash = map['file_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hash': file_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The selfie contains an error. The error is considered resolved when the file with the selfie changes
class InputPassportElementErrorSourceSelfie
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceSelfie';

  /// Current hash of the file containing the selfie
  bytes? file_hash;

  InputPassportElementErrorSourceSelfie({
    super.extra,
    super.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceSelfie.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_hash = map['file_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hash': file_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// One of the files containing the translation of the document contains an error. The error is considered resolved when the file with the translation changes
class InputPassportElementErrorSourceTranslationFile
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceTranslationFile';

  /// Current hash of the file containing the translation
  bytes? file_hash;

  InputPassportElementErrorSourceTranslationFile({
    super.extra,
    super.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceTranslationFile.fromMap(
      Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_hash = map['file_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hash': file_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The translation of the document contains an error. The error is considered resolved when the list of files changes
class InputPassportElementErrorSourceTranslationFiles
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceTranslationFiles';

  /// Current hashes of all files with the translation
  vector<bytes>? file_hashes;

  InputPassportElementErrorSourceTranslationFiles({
    super.extra,
    super.client_id,
    this.file_hashes,
  });

  InputPassportElementErrorSourceTranslationFiles.fromMap(
      Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file_hashes'] != null) {
      file_hashes = [];
      for (var someValue in map['file_hashes']) {
        file_hashes?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hashes': file_hashes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The file contains an error. The error is considered resolved when the file changes
class InputPassportElementErrorSourceFile
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFile';

  /// Current hash of the file which has the error
  bytes? file_hash;

  InputPassportElementErrorSourceFile({
    super.extra,
    super.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_hash = map['file_hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hash': file_hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The list of attached files contains an error. The error is considered resolved when the file list changes
class InputPassportElementErrorSourceFiles
    extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFiles';

  /// Current hashes of all attached files
  vector<bytes>? file_hashes;

  InputPassportElementErrorSourceFiles({
    super.extra,
    super.client_id,
    this.file_hashes,
  });

  InputPassportElementErrorSourceFiles.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file_hashes'] != null) {
      file_hashes = [];
      for (var someValue in map['file_hashes']) {
        file_hashes?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_hashes': file_hashes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
