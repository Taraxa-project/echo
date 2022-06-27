import 'package:td_json_client/api/base.dart';

class GetSuggestedFileName extends TdFunction {
  String get tdType => 'getSuggestedFileName';
  String get tdReturnType => 'Text';

  string? extra;
  int? client_id;
  int32? file_id;
  string? directory;

  GetSuggestedFileName({
    this.extra,
    this.client_id,
    this.file_id,
    this.directory,
  });

  GetSuggestedFileName.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    directory = map['directory'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'directory': directory?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
