import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/internal_link_type.dart';

/// Describes the target chat to be opened
abstract class TargetChat extends TdObject {
  TargetChat({super.extra, super.client_id});
}


/// The currently opened chat needs to be kept
class TargetChatCurrent extends TargetChat {
  String get tdType => 'targetChatCurrent';


  TargetChatCurrent({
    super.extra,
    super.client_id,
  });

  TargetChatCurrent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat needs to be chosen by the user among chats of the specified types
class TargetChatChosen extends TargetChat {
  String get tdType => 'targetChatChosen';


  /// True, if private chats with ordinary users are allowed
  Bool? allow_user_chats;

  /// True, if private chats with other bots are allowed
  Bool? allow_bot_chats;

  /// True, if basic group and supergroup chats are allowed
  Bool? allow_group_chats;

  /// True, if channel chats are allowed
  Bool? allow_channel_chats;

  TargetChatChosen({
    super.extra,
    super.client_id,
    this.allow_user_chats,
    this.allow_bot_chats,
    this.allow_group_chats,
    this.allow_channel_chats,
  });

  TargetChatChosen.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    allow_user_chats = map['allow_user_chats'];
    allow_bot_chats = map['allow_bot_chats'];
    allow_group_chats = map['allow_group_chats'];
    allow_channel_chats = map['allow_channel_chats'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'allow_user_chats': allow_user_chats?.toMap(skipNulls: skipNulls),
      'allow_bot_chats': allow_bot_chats?.toMap(skipNulls: skipNulls),
      'allow_group_chats': allow_group_chats?.toMap(skipNulls: skipNulls),
      'allow_channel_chats': allow_channel_chats?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat needs to be open with the provided internal link 
class TargetChatInternalLink extends TargetChat {
  String get tdType => 'targetChatInternalLink';


  /// An internal link pointing to the chat
  InternalLinkType? link;

  TargetChatInternalLink({
    super.extra,
    super.client_id,
    this.link,
  });

  TargetChatInternalLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['link'] != null) {
      link = TdApiMap.fromMap(map['link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'link': link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
