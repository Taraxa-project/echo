import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class InputPersonalDocument extends TdObject {
  String get tdType => 'inputPersonalDocument';

  string? extra;
  int? client_id;
  vector<InputFile>? files;
  vector<InputFile>? translation;

  InputPersonalDocument({
    this.extra,
    this.client_id,
    this.files,
    this.translation,
  });

  InputPersonalDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['files']) {
      files = [];
      for (var someValue in map['files']) {
        files?.add(TdApiMap.fromMap(someValue) as InputFile);
      }
    }
    if (map['translation']) {
      translation = [];
      for (var someValue in map['translation']) {
        translation?.add(TdApiMap.fromMap(someValue) as InputFile);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'files': files?.toMap(skipNulls: skipNulls),
      'translation': translation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
