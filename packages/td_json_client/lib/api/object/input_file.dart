import 'package:td_json_client/api/base.dart';

abstract class InputFile extends TdObject {}

class InputFileId extends InputFile {
  String get tdType => 'inputFileId';

  String? extra;
  int? client_id;
  int32? id;

  InputFileId({
    this.extra,
    this.client_id,
    this.id,
  });

  InputFileId.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputFileRemote extends InputFile {
  String get tdType => 'inputFileRemote';

  String? extra;
  int? client_id;
  string? id;

  InputFileRemote({
    this.extra,
    this.client_id,
    this.id,
  });

  InputFileRemote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputFileLocal extends InputFile {
  String get tdType => 'inputFileLocal';

  String? extra;
  int? client_id;
  string? path;

  InputFileLocal({
    this.extra,
    this.client_id,
    this.path,
  });

  InputFileLocal.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    path = map['path'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'path': path?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputFileGenerated extends InputFile {
  String get tdType => 'inputFileGenerated';

  String? extra;
  int? client_id;
  string? original_path;
  string? conversion;
  int32? expected_size;

  InputFileGenerated({
    this.extra,
    this.client_id,
    this.original_path,
    this.conversion,
    this.expected_size,
  });

  InputFileGenerated.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    original_path = map['original_path'];
    conversion = map['conversion'];
    expected_size = map['expected_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'original_path': original_path?.toMap(skipNulls: skipNulls),
      'conversion': conversion?.toMap(skipNulls: skipNulls),
      'expected_size': expected_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
