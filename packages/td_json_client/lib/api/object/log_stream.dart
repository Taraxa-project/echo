import 'package:td_json_client/api/base.dart';

/// Describes a stream to which TDLib internal log is written
abstract class LogStream extends TdObject {}


/// The log is written to stderr or an OS specific log
class LogStreamDefault extends LogStream {
  String get tdType => 'logStreamDefault';

  String? extra;
  int? client_id;

  LogStreamDefault({
    this.extra,
    this.client_id,
  });

  LogStreamDefault.fromMap(Map<String, dynamic> map) {
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

/// The log is written to a file
class LogStreamFile extends LogStream {
  String get tdType => 'logStreamFile';

  String? extra;
  int? client_id;

  /// Path to the file to where the internal TDLib log will be written
  string? path;

  /// The maximum size of the file to where the internal TDLib log is written before the file will automatically be rotated, in bytes
  int53? max_file_size;

  /// Pass true to additionally redirect stderr to the log file. Ignored on Windows
  Bool? redirect_stderr;

  LogStreamFile({
    this.extra,
    this.client_id,
    this.path,
    this.max_file_size,
    this.redirect_stderr,
  });

  LogStreamFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    path = map['path'];
    max_file_size = map['max_file_size'];
    redirect_stderr = map['redirect_stderr'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'path': path?.toMap(skipNulls: skipNulls),
      'max_file_size': max_file_size?.toMap(skipNulls: skipNulls),
      'redirect_stderr': redirect_stderr?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The log is written nowhere
class LogStreamEmpty extends LogStream {
  String get tdType => 'logStreamEmpty';

  String? extra;
  int? client_id;

  LogStreamEmpty({
    this.extra,
    this.client_id,
  });

  LogStreamEmpty.fromMap(Map<String, dynamic> map) {
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
