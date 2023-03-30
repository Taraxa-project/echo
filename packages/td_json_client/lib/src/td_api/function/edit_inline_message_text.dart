import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Edits the text of an inline text or game message sent via a bot; for bots only
class EditInlineMessageText extends TdFunction {
  String get tdType => 'editInlineMessageText';
  String get tdReturnType => 'Ok';

  /// Inline message identifier
  string? inline_message_id;

  /// The new message reply markup; pass null if none
  ReplyMarkup? reply_markup;

  /// New text content of the message. Must be of type inputMessageText
  InputMessageContent? input_message_content;

  EditInlineMessageText({
    super.extra,
    super.client_id,
    this.inline_message_id,
    this.reply_markup,
    this.input_message_content,
  });

  EditInlineMessageText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content =
          TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content':
          input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
