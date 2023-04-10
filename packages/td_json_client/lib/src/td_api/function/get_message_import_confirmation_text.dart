import 'package:td_json_client/src/td_api/td.dart';

/// Returns a confirmation text to be shown to the user before starting message import
class GetMessageImportConfirmationText extends TdFunction {
  String get tdType => 'getMessageImportConfirmationText';
  String get tdReturnType => 'Text';

  /// Identifier of a chat to which the messages will be imported. It must be an identifier of a private chat with a mutual contact or an identifier of a supergroup chat with can_change_info administrator right
  int53? chat_id;

  GetMessageImportConfirmationText({
    super.extra,
    super.client_id,
    this.chat_id,
  });

  GetMessageImportConfirmationText.fromMap(Map<String, dynamic> map) {
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
