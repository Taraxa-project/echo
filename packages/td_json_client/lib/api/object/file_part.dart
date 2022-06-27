import 'package:td_json_client/api/base.dart';

class FilePart extends TdObject {
  String get tdType => 'filePart';

  String? extra;
  int? client_id;
  bytes? data;

  FilePart({
    this.extra,
    this.client_id,
    this.data,
  });

  FilePart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
