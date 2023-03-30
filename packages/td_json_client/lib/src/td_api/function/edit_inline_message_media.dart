import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/reply_markup.dart';
import 'package:td_json_client/src/td_api/object/input_message_content.dart';

/// Edits the content of a message with an animation, an audio, a document, a photo or a video in an inline message sent via a bot; for bots only
class EditInlineMessageMedia extends TdFunction {
  String get tdType => 'editInlineMessageMedia';
  String get tdReturnType => 'Ok';

  /// Inline message identifier
  string? inline_message_id;

  /// The new message reply markup; pass null if none; for bots only
  ReplyMarkup? reply_markup;

  /// New content of the message. Must be one of the following types: inputMessageAnimation, inputMessageAudio, inputMessageDocument, inputMessagePhoto or inputMessageVideo
  InputMessageContent? input_message_content;

  EditInlineMessageMedia({
    super.extra,
    super.client_id,
    this.inline_message_id,
    this.reply_markup,
    this.input_message_content,
  });

  EditInlineMessageMedia.fromMap(Map<String, dynamic> map) {
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
