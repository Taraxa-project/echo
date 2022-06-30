import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/dated_file.dart';


/// A personal document, containing some information about a user 
class PersonalDocument extends TdObject {
  String get tdType => 'personalDocument';


  /// List of files containing the pages of the document 
  vector<DatedFile>? files;

  /// List of files containing a certified English translation of the document
  vector<DatedFile>? translation;

  PersonalDocument({
    super.extra,
    super.client_id,
    this.files,
    this.translation,
  });

  PersonalDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['files'] != null) {
      files = [];
      for (var someValue in map['files']) {
        if (someValue != null) {
          files?.add(TdApiMap.fromMap(someValue) as DatedFile);
        }
      }
    }
    if (map['translation'] != null) {
      translation = [];
      for (var someValue in map['translation']) {
        if (someValue != null) {
          translation?.add(TdApiMap.fromMap(someValue) as DatedFile);
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
