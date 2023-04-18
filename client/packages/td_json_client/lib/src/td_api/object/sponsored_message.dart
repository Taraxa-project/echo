import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_invite_link_info.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';
import 'package:td_json_client/src/td_api/object/message_content.dart';

/// Describes a sponsored message
class SponsoredMessage extends TdObject {
  String get tdType => 'sponsoredMessage';

  /// Message identifier; unique for the chat to which the sponsored message belongs among both ordinary and sponsored messages
  int53? message_id;

  /// True, if the message needs to be labeled as "recommended" instead of "sponsored"
  Bool? is_recommended;

  /// Sponsor chat identifier; 0 if the sponsor chat is accessible through an invite link
  int53? sponsor_chat_id;

  /// Information about the sponsor chat; may be null unless sponsor_chat_id == 0
  ChatInviteLinkInfo? sponsor_chat_info;

  /// True, if the sponsor's chat photo must be shown
  Bool? show_chat_photo;

  /// An internal link to be opened when the sponsored message is clicked; may be null if the sponsor chat needs to be opened instead
  InternalLinkType? link;

  /// Content of the message. Currently, can be only of the type messageText
  MessageContent? content;

  SponsoredMessage({
    super.extra,
    super.client_id,
    this.message_id,
    this.is_recommended,
    this.sponsor_chat_id,
    this.sponsor_chat_info,
    this.show_chat_photo,
    this.link,
    this.content,
  });

  SponsoredMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    is_recommended = map['is_recommended'];
    sponsor_chat_id = map['sponsor_chat_id'];
    if (map['sponsor_chat_info'] != null) {
      sponsor_chat_info = TdApiMap.fromMap(map['sponsor_chat_info']) as ChatInviteLinkInfo;
    }
    show_chat_photo = map['show_chat_photo'];
    if (map['link'] != null) {
      link = TdApiMap.fromMap(map['link']) as InternalLinkType;
    }
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as MessageContent;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'is_recommended': is_recommended?.toMap(skipNulls: skipNulls),
      'sponsor_chat_id': sponsor_chat_id?.toMap(skipNulls: skipNulls),
      'sponsor_chat_info': sponsor_chat_info?.toMap(skipNulls: skipNulls),
      'show_chat_photo': show_chat_photo?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
