import 'package:td_json_client/api/base.dart';

abstract class PassportElementErrorSource extends TdObject {}

class PassportElementErrorSourceUnspecified extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceUnspecified';

  String? extra;
  int? client_id;

  PassportElementErrorSourceUnspecified({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceUnspecified.fromMap(Map<String, dynamic> map) {
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
class PassportElementErrorSourceDataField extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceDataField';

  String? extra;
  int? client_id;
  string? field_name;

  PassportElementErrorSourceDataField({
    this.extra,
    this.client_id,
    this.field_name,
  });

  PassportElementErrorSourceDataField.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    field_name = map['field_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'field_name': field_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class PassportElementErrorSourceFrontSide extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceFrontSide';

  String? extra;
  int? client_id;

  PassportElementErrorSourceFrontSide({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceFrontSide.fromMap(Map<String, dynamic> map) {
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
class PassportElementErrorSourceReverseSide extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceReverseSide';

  String? extra;
  int? client_id;

  PassportElementErrorSourceReverseSide({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceReverseSide.fromMap(Map<String, dynamic> map) {
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
class PassportElementErrorSourceSelfie extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceSelfie';

  String? extra;
  int? client_id;

  PassportElementErrorSourceSelfie({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceSelfie.fromMap(Map<String, dynamic> map) {
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
class PassportElementErrorSourceTranslationFile extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceTranslationFile';

  String? extra;
  int? client_id;
  int32? file_index;

  PassportElementErrorSourceTranslationFile({
    this.extra,
    this.client_id,
    this.file_index,
  });

  PassportElementErrorSourceTranslationFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_index = map['file_index'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_index': file_index?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class PassportElementErrorSourceTranslationFiles extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceTranslationFiles';

  String? extra;
  int? client_id;

  PassportElementErrorSourceTranslationFiles({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceTranslationFiles.fromMap(Map<String, dynamic> map) {
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
class PassportElementErrorSourceFile extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceFile';

  String? extra;
  int? client_id;
  int32? file_index;

  PassportElementErrorSourceFile({
    this.extra,
    this.client_id,
    this.file_index,
  });

  PassportElementErrorSourceFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_index = map['file_index'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_index': file_index?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class PassportElementErrorSourceFiles extends PassportElementErrorSource {
  String get tdType => 'passportElementErrorSourceFiles';

  String? extra;
  int? client_id;

  PassportElementErrorSourceFiles({
    this.extra,
    this.client_id,
  });

  PassportElementErrorSourceFiles.fromMap(Map<String, dynamic> map) {
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
