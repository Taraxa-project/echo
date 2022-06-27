import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/internal_link_type.dart';
import 'package:td_json_client/api/object/message_content.dart';

class SponsoredMessage extends TdObject {
  String get tdType => 'sponsoredMessage';

  string? extra;
  int? client_id;
  int53? message_id;
  int53? sponsor_chat_id;
  InternalLinkType? link;
  MessageContent? content;

  SponsoredMessage({
    this.extra,
    this.client_id,
    this.message_id,
    this.sponsor_chat_id,
    this.link,
    this.content,
  });

  SponsoredMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    sponsor_chat_id = map['sponsor_chat_id'];
    link = TdApiMap.fromMap(map['link']) as InternalLinkType;
    content = TdApiMap.fromMap(map['content']) as MessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'sponsor_chat_id': sponsor_chat_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
