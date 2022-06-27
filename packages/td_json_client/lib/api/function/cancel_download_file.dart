import 'package:td_json_client/api/base.dart';

class CancelDownloadFile extends TdFunction {
  String get tdType => 'cancelDownloadFile';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  int32? file_id;
  Bool? only_if_pending;

  CancelDownloadFile({
    this.extra,
    this.client_id,
    this.file_id,
    this.only_if_pending,
  });

  CancelDownloadFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_id = map['file_id'];
    only_if_pending = map['only_if_pending'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_id': file_id?.toMap(skipNulls: skipNulls),
      'only_if_pending': only_if_pending?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
