import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/contact.dart';


/// Adds new contacts or edits existing contacts by their phone numbers; contacts' user identifiers are ignored 
class ImportContacts extends TdFunction {
  String get tdType => 'importContacts';
  String get tdReturnType => 'ImportedContacts';


  /// The list of contacts to import or edit; contacts' vCard are ignored and are not imported
  vector<Contact>? contacts;

  ImportContacts({
    super.extra,
    super.client_id,
    this.contacts,
  });

  ImportContacts.fromMap(Map<String, dynamic> map) {
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
