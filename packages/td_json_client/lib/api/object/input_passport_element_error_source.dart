import 'package:td_json_client/api/base.dart';

abstract class InputPassportElementErrorSource extends TdObject {}

class InputPassportElementErrorSourceUnspecified extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceUnspecified';

  string? extra;
  int? client_id;
  bytes? element_hash;

  InputPassportElementErrorSourceUnspecified({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceDataField extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceDataField';

  string? extra;
  int? client_id;
  string? field_name;
  bytes? data_hash;

  InputPassportElementErrorSourceDataField({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceFrontSide extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFrontSide';

  string? extra;
  int? client_id;
  bytes? file_hash;

  InputPassportElementErrorSourceFrontSide({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceReverseSide extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceReverseSide';

  string? extra;
  int? client_id;
  bytes? file_hash;

  InputPassportElementErrorSourceReverseSide({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceSelfie extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceSelfie';

  string? extra;
  int? client_id;
  bytes? file_hash;

  InputPassportElementErrorSourceSelfie({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceTranslationFile extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceTranslationFile';

  string? extra;
  int? client_id;
  bytes? file_hash;

  InputPassportElementErrorSourceTranslationFile({
    this.extra,
    this.client_id,
    this.file_hash,
  });

  InputPassportElementErrorSourceTranslationFile.fromMap(Map<String, dynamic> map) {
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
class InputPassportElementErrorSourceTranslationFiles extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceTranslationFiles';

  string? extra;
  int? client_id;
  vector<bytes>? file_hashes;

  InputPassportElementErrorSourceTranslationFiles({
    this.extra,
    this.client_id,
    this.file_hashes,
  });

  InputPassportElementErrorSourceTranslationFiles.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file_hashes']) {
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
class InputPassportElementErrorSourceFile extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFile';

  string? extra;
  int? client_id;
  bytes? file_hash;

  InputPassportElementErrorSourceFile({
    this.extra,
    this.client_id,
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
class InputPassportElementErrorSourceFiles extends InputPassportElementErrorSource {
  String get tdType => 'inputPassportElementErrorSourceFiles';

  string? extra;
  int? client_id;
  vector<bytes>? file_hashes;

  InputPassportElementErrorSourceFiles({
    this.extra,
    this.client_id,
    this.file_hashes,
  });

  InputPassportElementErrorSourceFiles.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file_hashes']) {
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
