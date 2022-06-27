import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_message_content.dart';

class DraftMessage extends TdObject {
  String get tdType => 'draftMessage';

  string? extra;
  int? client_id;
  int53? reply_to_message_id;
  int32? date;
  InputMessageContent? input_message_text;

  DraftMessage({
    this.extra,
    this.client_id,
    this.reply_to_message_id,
    this.date,
    this.input_message_text,
  });

  DraftMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reply_to_message_id = map['reply_to_message_id'];
    date = map['date'];
    input_message_text = TdApiMap.fromMap(map['input_message_text']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reply_to_message_id': reply_to_message_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'input_message_text': input_message_text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}