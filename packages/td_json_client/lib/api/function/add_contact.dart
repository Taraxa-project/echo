import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/contact.dart';

class AddContact extends TdFunction {
  String get tdType => 'addContact';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  Contact? contact;
  Bool? share_phone_number;

  AddContact({
    this.extra,
    this.client_id,
    this.contact,
    this.share_phone_number,
  });

  AddContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    contact = TdApiMap.fromMap(map['contact']) as Contact;
    share_phone_number = map['share_phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'contact': contact?.toMap(skipNulls: skipNulls),
      'share_phone_number': share_phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
