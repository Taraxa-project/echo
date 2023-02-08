import 'package:td_json_client/api/base.dart';

/// Represents the result of an importContacts request
class ImportedContacts extends TdObject {
  String get tdType => 'importedContacts';

  /// User identifiers of the imported contacts in the same order as they were specified in the request; 0 if the contact is not yet a registered user
  vector<int53>? user_ids;

  /// The number of users that imported the corresponding contact; 0 for already registered users or if unavailable
  vector<int32>? importer_count;

  ImportedContacts({
    super.extra,
    super.client_id,
    this.user_ids,
    this.importer_count,
  });

  ImportedContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['user_ids'] != null) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
    if (map['importer_count'] != null) {
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
