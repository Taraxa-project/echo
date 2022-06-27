import 'package:td_json_client/api/base.dart';


/// Returns the MIME type of a file, guessed by its extension. Returns an empty string on failure. Can be called synchronously 
class GetFileMimeType extends TdFunction {
  String get tdType => 'getFileMimeType';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;

  /// The name of the file or path to the file
  string? file_name;

  GetFileMimeType({
    this.extra,
    this.client_id,
    this.file_name,
  });

  GetFileMimeType.fromMap(Map<String, dynamic> map) {
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
