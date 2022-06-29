import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// A personal document to be saved to Telegram Passport 
class InputPersonalDocument extends TdObject {
  String get tdType => 'inputPersonalDocument';

  String? extra;
  int? client_id;

  /// List of files containing the pages of the document 
  vector<InputFile>? files;

  /// List of files containing a certified English translation of the document
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
    if (map['files'] != null) {
      files = [];
      for (var someValue in map['files']) {
        if (someValue != null) {
          files?.add(TdApiMap.fromMap(someValue) as InputFile);
        }
      }
    }
    if (map['translation'] != null) {
      translation = [];
      for (var someValue in map['translation']) {
        if (someValue != null) {
          translation?.add(TdApiMap.fromMap(someValue) as InputFile);
        }
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
