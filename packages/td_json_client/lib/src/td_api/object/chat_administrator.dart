import 'package:td_json_client/src/td_api/td.dart';

/// Contains information about a chat administrator
class ChatAdministrator extends TdObject {
  String get tdType => 'chatAdministrator';

  /// User identifier of the administrator
  int53? user_id;

  /// Custom title of the administrator
  string? custom_title;

  /// True, if the user is the owner of the chat
  Bool? is_owner;

  ChatAdministrator({
    super.extra,
    super.client_id,
    this.user_id,
    this.custom_title,
    this.is_owner,
  });

  ChatAdministrator.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    custom_title = map['custom_title'];
    is_owner = map['is_owner'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'custom_title': custom_title?.toMap(skipNulls: skipNulls),
      'is_owner': is_owner?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
