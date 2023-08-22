import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_content.dart';
import 'package:td_json_client/src/td_api/object/message_sponsor.dart';

/// Describes a sponsored message
class SponsoredMessage extends TdObject {
  String get tdType => 'sponsoredMessage';

  /// Message identifier; unique for the chat to which the sponsored message belongs among both ordinary and sponsored messages
  int53? message_id;

  /// True, if the message needs to be labeled as "recommended" instead of "sponsored"
  Bool? is_recommended;

  /// Content of the message. Currently, can be only of the type messageText
  MessageContent? content;

  /// Information about the sponsor of the message
  MessageSponsor? sponsor;

  /// If non-empty, additional information about the sponsored message to be shown along with the message
  string? additional_info;

  SponsoredMessage({
    super.extra,
    super.client_id,
    this.message_id,
    this.is_recommended,
    this.content,
    this.sponsor,
    this.additional_info,
  });

  SponsoredMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
    is_recommended = map['is_recommended'];
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as MessageContent;
    }
    if (map['sponsor'] != null) {
      sponsor = TdApiMap.fromMap(map['sponsor']) as MessageSponsor;
    }
    additional_info = map['additional_info'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'is_recommended': is_recommended?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
      'sponsor': sponsor?.toMap(skipNulls: skipNulls),
      'additional_info': additional_info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
