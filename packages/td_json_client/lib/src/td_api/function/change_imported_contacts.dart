import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/contact.dart';

/// Changes imported contacts using the list of contacts saved on the device. Imports newly added contacts and, if at least the file database is enabled, deletes recently deleted contacts.
/// Query result depends on the result of the previous query, so only one query is possible at the same time
class ChangeImportedContacts extends TdFunction {
  String get tdType => 'changeImportedContacts';
  String get tdReturnType => 'ImportedContacts';

  /// The new list of contacts, contact's vCard are ignored and are not imported
  vector<Contact>? contacts;

  ChangeImportedContacts({
    super.extra,
    super.client_id,
    this.contacts,
  });

  ChangeImportedContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['contacts'] != null) {
      contacts = [];
      for (var someValue in map['contacts']) {
        if (someValue != null) {
          contacts?.add(TdApiMap.fromMap(someValue) as Contact);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'contacts': contacts?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
