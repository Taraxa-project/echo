import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';

/// Describes type of a message sponsor
abstract class MessageSponsorType extends TdObject {
  MessageSponsorType({super.extra, super.client_id});
}

/// The sponsor is a bot
class MessageSponsorTypeBot extends MessageSponsorType {
  String get tdType => 'messageSponsorTypeBot';

  /// User identifier of the bot
  int53? bot_user_id;

  /// An internal link to be opened when the sponsored message is clicked
  InternalLinkType? link;

  MessageSponsorTypeBot({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.link,
  });

  MessageSponsorTypeBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    if (map['link'] != null) {
      link = TdApiMap.fromMap(map['link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sponsor is a public channel chat
class MessageSponsorTypePublicChannel extends MessageSponsorType {
  String get tdType => 'messageSponsorTypePublicChannel';

  /// Sponsor chat identifier
  int53? chat_id;

  /// An internal link to be opened when the sponsored message is clicked; may be null if the sponsor chat needs to be opened instead
  InternalLinkType? link;

  MessageSponsorTypePublicChannel({
    super.extra,
    super.client_id,
    this.chat_id,
    this.link,
  });

  MessageSponsorTypePublicChannel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_id = map['chat_id'];
    if (map['link'] != null) {
      link = TdApiMap.fromMap(map['link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_id': chat_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sponsor is a private channel chat
class MessageSponsorTypePrivateChannel extends MessageSponsorType {
  String get tdType => 'messageSponsorTypePrivateChannel';

  /// Title of the chat
  string? title;

  /// Invite link for the channel
  string? invite_link;

  MessageSponsorTypePrivateChannel({
    super.extra,
    super.client_id,
    this.title,
    this.invite_link,
  });

  MessageSponsorTypePrivateChannel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    invite_link = map['invite_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The sponsor is a website
class MessageSponsorTypeWebsite extends MessageSponsorType {
  String get tdType => 'messageSponsorTypeWebsite';

  /// URL of the website
  string? url;

  /// Name of the website
  string? name;

  MessageSponsorTypeWebsite({
    super.extra,
    super.client_id,
    this.url,
    this.name,
  });

  MessageSponsorTypeWebsite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
