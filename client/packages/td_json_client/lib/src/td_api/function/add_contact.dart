import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/contact.dart';

/// Adds a user to the contact list or edits an existing contact by their user identifier
class AddContact extends TdFunction {
  String get tdType => 'addContact';
  String get tdReturnType => 'Ok';

  /// The contact to add or edit; phone number may be empty and needs to be specified only if known, vCard is ignored
  Contact? contact;

  /// Pass true to share the current user's phone number with the new contact. A corresponding rule to userPrivacySettingShowPhoneNumber will be added if needed.
  /// Use the field userFullInfo.need_phone_number_privacy_exception to check whether the current user needs to be asked to share their phone number
  Bool? share_phone_number;

  AddContact({
    super.extra,
    super.client_id,
    this.contact,
    this.share_phone_number,
  });

  AddContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['contact'] != null) {
      contact = TdApiMap.fromMap(map['contact']) as Contact;
    }
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
