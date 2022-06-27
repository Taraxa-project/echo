import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

abstract class InputBackground extends TdObject {}

class InputBackgroundLocal extends InputBackground {
  String get tdType => 'inputBackgroundLocal';

  String? extra;
  int? client_id;
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
class InputBackgroundRemote extends InputBackground {
  String get tdType => 'inputBackgroundRemote';

  String? extra;
  int? client_id;
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
