import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/input_message_content.dart';


/// Edits the text of a message (or a text of a game message). Returns the edited message after the edit is completed on the server side
class EditMessageText extends TdFunction {
  String get tdType => 'editMessageText';
  String get tdReturnType => 'Message';

  String? extra;
  int? client_id;

  /// The chat the message belongs to
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// The new message reply markup; pass null if none; for bots only
  ReplyMarkup? reply_markup;

  /// New text content of the message. Must be of type inputMessageText
  InputMessageContent? input_message_content;

  EditMessageText({
    this.extra,
    this.client_id,
    this.chat_id,
    this.message_id,
    this.reply_markup,
    this.input_message_content,
  });

  EditMessageText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
