import 'package:td_json_client/api/base.dart';


/// Replaces current primary invite link for a chat with a new primary invite link. Available for basic groups, supergroups, and channels. Requires administrator privileges and can_invite_users right 
class ReplacePrimaryChatInviteLink extends TdFunction {
  String get tdType => 'replacePrimaryChatInviteLink';
  String get tdReturnType => 'ChatInviteLink';

  String? extra;
  int? client_id;

  /// Chat identifier
  int53? chat_id;

  ReplacePrimaryChatInviteLink({
    this.extra,
    this.client_id,
    this.chat_id,
  });

  ReplacePrimaryChatInviteLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
