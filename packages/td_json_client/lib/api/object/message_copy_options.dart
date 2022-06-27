import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';

class MessageCopyOptions extends TdObject {
  String get tdType => 'messageCopyOptions';

  string? extra;
  int? client_id;
  Bool? send_copy;
  Bool? replace_caption;
  FormattedText? new_caption;

  MessageCopyOptions({
    this.extra,
    this.client_id,
    this.send_copy,
    this.replace_caption,
    this.new_caption,
  });

  MessageCopyOptions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    send_copy = map['send_copy'];
    replace_caption = map['replace_caption'];
    new_caption = TdApiMap.fromMap(map['new_caption']) as FormattedText;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'send_copy': send_copy?.toMap(skipNulls: skipNulls),
      'replace_caption': replace_caption?.toMap(skipNulls: skipNulls),
      'new_caption': new_caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
