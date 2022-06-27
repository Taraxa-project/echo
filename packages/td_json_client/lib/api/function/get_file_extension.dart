import 'package:td_json_client/api/base.dart';

class GetFileExtension extends TdFunction {
  String get tdType => 'getFileExtension';
  String get tdReturnType => 'Text';

  String? extra;
  int? client_id;
  string? mime_type;

  GetFileExtension({
    this.extra,
    this.client_id,
    this.mime_type,
  });

  GetFileExtension.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    mime_type = map['mime_type'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
