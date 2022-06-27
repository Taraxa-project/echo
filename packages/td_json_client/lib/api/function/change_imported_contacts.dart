import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/contact.dart';

class ChangeImportedContacts extends TdFunction {
  String get tdType => 'changeImportedContacts';
  String get tdReturnType => 'ImportedContacts';

  String? extra;
  int? client_id;
  vector<Contact>? contacts;

  ChangeImportedContacts({
    this.extra,
    this.client_id,
    this.contacts,
  });

  ChangeImportedContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['contacts']) {
      contacts = [];
      for (var someValue in map['contacts']) {
        contacts?.add(TdApiMap.fromMap(someValue) as Contact);
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
