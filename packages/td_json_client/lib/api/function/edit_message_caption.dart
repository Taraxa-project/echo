import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/formatted_text.dart';


/// Edits the message content caption. Returns the edited message after the edit is completed on the server side
class EditMessageCaption extends TdFunction {
  String get tdType => 'editMessageCaption';
  String get tdReturnType => 'Message';


  /// The chat the message belongs to
  int53? chat_id;

  /// Identifier of the message
  int53? message_id;

  /// The new message reply markup; pass null if none; for bots only
  ReplyMarkup? reply_markup;

  /// New message content caption; 0-GetOption("message_caption_length_max") characters; pass null to remove caption
  FormattedText? caption;

  EditMessageCaption({
    super.extra,
    super.client_id,
    this.chat_id,
    this.message_id,
    this.reply_markup,
    this.caption,
  });

  EditMessageCaption.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    message_id = map['message_id'];
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
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
