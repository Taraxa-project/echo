import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';

class DatedFile extends TdObject {
  String get tdType => 'datedFile';

  string? extra;
  int? client_id;
  File? file;
  int32? date;

  DatedFile({
    this.extra,
    this.client_id,
    this.file,
    this.date,
  });

  DatedFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file = TdApiMap.fromMap(map['file']) as File;
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file': file?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
