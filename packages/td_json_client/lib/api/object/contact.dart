import 'package:td_json_client/api/base.dart';


/// Describes a user contact 
class Contact extends TdObject {
  String get tdType => 'contact';


  /// Phone number of the user 
  string? phone_number;

  /// First name of the user; 1-255 characters in length 
  string? first_name;

  /// Last name of the user 
  string? last_name;

  /// Additional data about the user in a form of vCard; 0-2048 bytes in length 
  string? vcard;

  /// Identifier of the user, if known; otherwise 0
  int53? user_id;

  Contact({
    super.extra,
    super.client_id,
    this.phone_number,
    this.first_name,
    this.last_name,
    this.vcard,
    this.user_id,
  });

  Contact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    vcard = map['vcard'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
      'vcard': vcard?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
