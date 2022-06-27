import 'package:td_json_client/api/base.dart';


/// Removes potentially dangerous characters from the name of a file. The encoding of the file name is supposed to be UTF-8. Returns an empty string on failure. Can be called synchronously 
class CleanFileName extends TdFunction {
  String get tdType => 'cleanFileName';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;

  /// File name or path to the file
  string? file_name;

  CleanFileName({
    this.extra,
    this.client_id,
    this.file_name,
  });

  CleanFileName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_name = map['file_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_name': file_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
