import 'package:td_json_client/api/base.dart';

class CleanFileName extends TdFunction {
  String get tdType => 'cleanFileName';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;
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
