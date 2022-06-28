import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

/// Contains information about background to set
abstract class InputBackground extends TdObject {}


/// A background from a local file
class InputBackgroundLocal extends InputBackground {
  String get tdType => 'inputBackgroundLocal';

  String? extra;
  int? client_id;

  /// Background file to use. Only inputFileLocal and inputFileGenerated are supported. The file must be in JPEG format for wallpapers and in PNG format for patterns
  InputFile? background;

  InputBackgroundLocal({
    this.extra,
    this.client_id,
    this.background,
  });

  InputBackgroundLocal.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background = TdApiMap.fromMap(map['background']) as InputFile;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A background from the server 
class InputBackgroundRemote extends InputBackground {
  String get tdType => 'inputBackgroundRemote';

  String? extra;
  int? client_id;

  /// The background identifier
  int64? background_id;

  InputBackgroundRemote({
    this.extra,
    this.client_id,
    this.background_id,
  });

  InputBackgroundRemote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background_id = map['background_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background_id': background_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
