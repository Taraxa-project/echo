import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// File with the date it was uploaded
class DatedFile extends TdObject {
  String get tdType => 'datedFile';

  /// The file
  File? file;

  /// Point in time (Unix timestamp) when the file was uploaded
  int32? date;

  DatedFile({
    super.extra,
    super.client_id,
    this.file,
    this.date,
  });

  DatedFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['file'] != null) {
      file = TdApiMap.fromMap(map['file']) as File;
    }
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
