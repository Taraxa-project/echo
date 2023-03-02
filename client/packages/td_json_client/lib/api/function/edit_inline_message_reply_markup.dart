import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';


/// Edits the reply markup of an inline message sent via a bot; for bots only
class EditInlineMessageReplyMarkup extends TdFunction {
  String get tdType => 'editInlineMessageReplyMarkup';
  String get tdReturnType => 'Ok';


  /// Inline message identifier
  string? inline_message_id;

  /// The new message reply markup; pass null if none
  ReplyMarkup? reply_markup;

  EditInlineMessageReplyMarkup({
    super.extra,
    super.client_id,
    this.inline_message_id,
    this.reply_markup,
  });

  EditInlineMessageReplyMarkup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    inline_message_id = map['inline_message_id'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'inline_message_id': inline_message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
