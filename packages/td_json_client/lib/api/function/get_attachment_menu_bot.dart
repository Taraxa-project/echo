import 'package:td_json_client/api/base.dart';


/// Returns information about a bot that can be added to attachment menu 
class GetAttachmentMenuBot extends TdFunction {
  String get tdType => 'getAttachmentMenuBot';
  String get tdReturnType => 'AttachmentMenuBot';

  String? extra;
  int? client_id;

  /// Bot's user identifier
  int53? bot_user_id;

  GetAttachmentMenuBot({
    this.extra,
    this.client_id,
    this.bot_user_id,
  });

  GetAttachmentMenuBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
