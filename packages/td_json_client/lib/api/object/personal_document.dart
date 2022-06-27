import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/dated_file.dart';


/// A personal document, containing some information about a user 
class PersonalDocument extends TdObject {
  String get tdType => 'personalDocument';

  String? extra;
  int? client_id;

  /// List of files containing the pages of the document 
  vector<DatedFile>? files;

  /// List of files containing a certified English translation of the document
  vector<DatedFile>? translation;

  PersonalDocument({
    this.extra,
    this.client_id,
    this.files,
    this.translation,
  });

  PersonalDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['files']) {
      files = [];
      for (var someValue in map['files']) {
        files?.add(TdApiMap.fromMap(someValue) as DatedFile);
      }
    }
    if (map['translation']) {
      translation = [];
      for (var someValue in map['translation']) {
        translation?.add(TdApiMap.fromMap(someValue) as DatedFile);
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
