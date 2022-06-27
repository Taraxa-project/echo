import 'package:td_json_client/api/base.dart';

class RemoveAllFilesFromDownloads extends TdFunction {
  String get tdType => 'removeAllFilesFromDownloads';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  Bool? only_active;
  Bool? only_completed;
  Bool? delete_from_cache;

  RemoveAllFilesFromDownloads({
    this.extra,
    this.client_id,
    this.only_active,
    this.only_completed,
    this.delete_from_cache,
  });

  RemoveAllFilesFromDownloads.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    only_active = map['only_active'];
    only_completed = map['only_completed'];
    delete_from_cache = map['delete_from_cache'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'only_active': only_active?.toMap(skipNulls: skipNulls),
      'only_completed': only_completed?.toMap(skipNulls: skipNulls),
      'delete_from_cache': delete_from_cache?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
