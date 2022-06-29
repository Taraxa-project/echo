import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';


/// Options to be used when a message content is copied without reference to the original sender. Service messages and messageInvoice can't be copied
class MessageCopyOptions extends TdObject {
  String get tdType => 'messageCopyOptions';

  String? extra;
  int? client_id;

  /// True, if content of the message needs to be copied without reference to the original sender. Always true if the message is forwarded to a secret chat or is local
  Bool? send_copy;

  /// True, if media caption of the message copy needs to be replaced. Ignored if send_copy is false
  Bool? replace_caption;

  /// New message caption; pass null to copy message without caption. Ignored if replace_caption is false
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
    if (map['new_caption'] != null) {
      new_caption = TdApiMap.fromMap(map['new_caption']) as FormattedText;
    }
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
