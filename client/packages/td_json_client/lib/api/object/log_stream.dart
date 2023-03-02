import 'package:td_json_client/api/base.dart';

/// Describes a stream to which TDLib internal log is written
abstract class LogStream extends TdObject {
  LogStream({super.extra, super.client_id});
}


/// The log is written to stderr or an OS specific log
class LogStreamDefault extends LogStream {
  String get tdType => 'logStreamDefault';


  LogStreamDefault({
    super.extra,
    super.client_id,
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


  /// Path to the file to where the internal TDLib log will be written
  string? path;

  /// The maximum size of the file to where the internal TDLib log is written before the file will automatically be rotated, in bytes
  int53? max_file_size;

  /// Pass true to additionally redirect stderr to the log file. Ignored on Windows
  Bool? redirect_stderr;

  LogStreamFile({
    super.extra,
    super.client_id,
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


  LogStreamEmpty({
    super.extra,
    super.client_id,
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
