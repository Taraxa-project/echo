import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/formatted_text.dart';


/// Edits the caption of an inline message sent via a bot; for bots only
class EditInlineMessageCaption extends TdFunction {
  String get tdType => 'editInlineMessageCaption';
  String get tdReturnType => 'Ok';


  /// Inline message identifier
  string? inline_message_id;

  /// The new message reply markup; pass null if none
  ReplyMarkup? reply_markup;

  /// New message content caption; pass null to remove caption; 0-getOption("message_caption_length_max") characters
  FormattedText? caption;

  EditInlineMessageCaption({
    super.extra,
    super.client_id,
    this.inline_message_id,
    this.reply_markup,
    this.caption,
  });

  EditInlineMessageCaption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
