import 'package:td_json_client/api/base.dart';

class ImportedContacts extends TdObject {
  String get tdType => 'importedContacts';

  String? extra;
  int? client_id;
  vector<int53>? user_ids;
  vector<int32>? importer_count;

  ImportedContacts({
    this.extra,
    this.client_id,
    this.user_ids,
    this.importer_count,
  });

  ImportedContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids']) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
    if (map['importer_count']) {
      importer_count = [];
      for (var someValue in map['importer_count']) {
        importer_count?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
      'importer_count': importer_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
