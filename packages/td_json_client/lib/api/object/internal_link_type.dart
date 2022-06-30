import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/proxy_type.dart';

/// Describes an internal https://t.me or tg: link, which must be processed by the app in a special way
abstract class InternalLinkType extends TdObject {
  InternalLinkType({super.extra, super.client_id});
}


/// The link is a link to the active sessions section of the app. Use getActiveSessions to handle the link
class InternalLinkTypeActiveSessions extends InternalLinkType {
  String get tdType => 'internalLinkTypeActiveSessions';


  InternalLinkTypeActiveSessions({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeActiveSessions.fromMap(Map<String, dynamic> map) {
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

/// The link contains an authentication code. Call checkAuthenticationCode with the code if the current authorization state is authorizationStateWaitCode 
class InternalLinkTypeAuthenticationCode extends InternalLinkType {
  String get tdType => 'internalLinkTypeAuthenticationCode';


  /// The authentication code
  string? code;

  InternalLinkTypeAuthenticationCode({
    super.extra,
    super.client_id,
    this.code,
  });

  InternalLinkTypeAuthenticationCode.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    code = map['code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'code': code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a background. Call searchBackground with the given background name to process the link 
class InternalLinkTypeBackground extends InternalLinkType {
  String get tdType => 'internalLinkTypeBackground';


  /// Name of the background
  string? background_name;

  InternalLinkTypeBackground({
    super.extra,
    super.client_id,
    this.background_name,
  });

  InternalLinkTypeBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background_name = map['background_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background_name': background_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a chat with a Telegram bot. Call searchPublicChat with the given bot username, check that the user is a bot, show START button in the chat with the bot,
/// and then call sendBotStartMessage with the given start parameter after the button is pressed
class InternalLinkTypeBotStart extends InternalLinkType {
  String get tdType => 'internalLinkTypeBotStart';


  /// Username of the bot 
  string? bot_username;

  /// The parameter to be passed to sendBotStartMessage
  string? start_parameter;

  InternalLinkTypeBotStart({
    super.extra,
    super.client_id,
    this.bot_username,
    this.start_parameter,
  });

  InternalLinkTypeBotStart.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_username = map['bot_username'];
    start_parameter = map['start_parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a Telegram bot, which is supposed to be added to a group chat. Call searchPublicChat with the given bot username, check that the user is a bot and can be added to groups,
/// ask the current user to select a group to add the bot to, and then call sendBotStartMessage with the given start parameter and the chosen group chat. Bots can be added to a public group only by administrators of the group
class InternalLinkTypeBotStartInGroup extends InternalLinkType {
  String get tdType => 'internalLinkTypeBotStartInGroup';


  /// Username of the bot 
  string? bot_username;

  /// The parameter to be passed to sendBotStartMessage
  string? start_parameter;

  InternalLinkTypeBotStartInGroup({
    super.extra,
    super.client_id,
    this.bot_username,
    this.start_parameter,
  });

  InternalLinkTypeBotStartInGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_username = map['bot_username'];
    start_parameter = map['start_parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to the change phone number section of the app
class InternalLinkTypeChangePhoneNumber extends InternalLinkType {
  String get tdType => 'internalLinkTypeChangePhoneNumber';


  InternalLinkTypeChangePhoneNumber({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeChangePhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// The link is a chat invite link. Call checkChatInviteLink with the given invite link to process the link 
class InternalLinkTypeChatInvite extends InternalLinkType {
  String get tdType => 'internalLinkTypeChatInvite';


  /// Internal representation of the invite link
  string? invite_link;

  InternalLinkTypeChatInvite({
    super.extra,
    super.client_id,
    this.invite_link,
  });

  InternalLinkTypeChatInvite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invite_link = map['invite_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invite_link': invite_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to the filter settings section of the app
class InternalLinkTypeFilterSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeFilterSettings';


  InternalLinkTypeFilterSettings({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeFilterSettings.fromMap(Map<String, dynamic> map) {
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

/// The link is a link to a game. Call searchPublicChat with the given bot username, check that the user is a bot, ask the current user to select a chat to send the game, and then call sendMessage with inputMessageGame
class InternalLinkTypeGame extends InternalLinkType {
  String get tdType => 'internalLinkTypeGame';


  /// Username of the bot that owns the game 
  string? bot_username;

  /// Short name of the game
  string? game_short_name;

  InternalLinkTypeGame({
    super.extra,
    super.client_id,
    this.bot_username,
    this.game_short_name,
  });

  InternalLinkTypeGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_username = map['bot_username'];
    game_short_name = map['game_short_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'game_short_name': game_short_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a language pack. Call getLanguagePackInfo with the given language pack identifier to process the link 
class InternalLinkTypeLanguagePack extends InternalLinkType {
  String get tdType => 'internalLinkTypeLanguagePack';


  /// Language pack identifier
  string? language_pack_id;

  InternalLinkTypeLanguagePack({
    super.extra,
    super.client_id,
    this.language_pack_id,
  });

  InternalLinkTypeLanguagePack.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    language_pack_id = map['language_pack_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'language_pack_id': language_pack_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a Telegram message. Call getMessageLinkInfo with the given URL to process the link 
class InternalLinkTypeMessage extends InternalLinkType {
  String get tdType => 'internalLinkTypeMessage';


  /// URL to be passed to getMessageLinkInfo
  string? url;

  InternalLinkTypeMessage({
    super.extra,
    super.client_id,
    this.url,
  });

  InternalLinkTypeMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link contains a message draft text. A share screen needs to be shown to the user, then the chosen chat must be opened and the text is added to the input field
class InternalLinkTypeMessageDraft extends InternalLinkType {
  String get tdType => 'internalLinkTypeMessageDraft';


  /// Message draft text 
  FormattedText? text;

  /// True, if the first line of the text contains a link. If true, the input field needs to be focused and the text after the link must be selected
  Bool? contains_link;

  InternalLinkTypeMessageDraft({
    super.extra,
    super.client_id,
    this.text,
    this.contains_link,
  });

  InternalLinkTypeMessageDraft.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
    contains_link = map['contains_link'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'contains_link': contains_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link contains a request of Telegram passport data. Call getPassportAuthorizationForm with the given parameters to process the link if the link was received from outside of the app, otherwise ignore it
class InternalLinkTypePassportDataRequest extends InternalLinkType {
  String get tdType => 'internalLinkTypePassportDataRequest';


  /// User identifier of the service's bot 
  int53? bot_user_id;

  /// Telegram Passport element types requested by the service 
  string? scope;

  /// Service's public key 
  string? public_key;

  /// Unique request identifier provided by the service
  string? nonce;

  /// An HTTP URL to open once the request is finished or canceled with the parameter tg_passport=success or tg_passport=cancel respectively. If empty, then the link tgbot{bot_user_id}://passport/success or tgbot{bot_user_id}://passport/cancel needs to be opened instead
  string? callback_url;

  InternalLinkTypePassportDataRequest({
    super.extra,
    super.client_id,
    this.bot_user_id,
    this.scope,
    this.public_key,
    this.nonce,
    this.callback_url,
  });

  InternalLinkTypePassportDataRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    scope = map['scope'];
    public_key = map['public_key'];
    nonce = map['nonce'];
    callback_url = map['callback_url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'scope': scope?.toMap(skipNulls: skipNulls),
      'public_key': public_key?.toMap(skipNulls: skipNulls),
      'nonce': nonce?.toMap(skipNulls: skipNulls),
      'callback_url': callback_url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link can be used to confirm ownership of a phone number to prevent account deletion. Call sendPhoneNumberConfirmationCode with the given hash and phone number to process the link
class InternalLinkTypePhoneNumberConfirmation extends InternalLinkType {
  String get tdType => 'internalLinkTypePhoneNumberConfirmation';


  /// Hash value from the link 
  string? hash;

  /// Phone number value from the link
  string? phone_number;

  InternalLinkTypePhoneNumberConfirmation({
    super.extra,
    super.client_id,
    this.hash,
    this.phone_number,
  });

  InternalLinkTypePhoneNumberConfirmation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    hash = map['hash'];
    phone_number = map['phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'hash': hash?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a proxy. Call addProxy with the given parameters to process the link and add the proxy
class InternalLinkTypeProxy extends InternalLinkType {
  String get tdType => 'internalLinkTypeProxy';


  /// Proxy server IP address 
  string? server;

  /// Proxy server port 
  int32? port;

  /// Type of the proxy
  ProxyType? type;

  InternalLinkTypeProxy({
    super.extra,
    super.client_id,
    this.server,
    this.port,
    this.type,
  });

  InternalLinkTypeProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    server = map['server'];
    port = map['port'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as ProxyType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'server': server?.toMap(skipNulls: skipNulls),
      'port': port?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a chat by its username. Call searchPublicChat with the given chat username to process the link 
class InternalLinkTypePublicChat extends InternalLinkType {
  String get tdType => 'internalLinkTypePublicChat';


  /// Username of the chat
  string? chat_username;

  InternalLinkTypePublicChat({
    super.extra,
    super.client_id,
    this.chat_username,
  });

  InternalLinkTypePublicChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_username = map['chat_username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_username': chat_username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link can be used to login the current user on another device, but it must be scanned from QR-code using in-app camera. An alert similar to
/// "This code can be used to allow someone to log in to your Telegram account. To confirm Telegram login, please go to Settings > Devices > Scan QR and scan the code" needs to be shown
class InternalLinkTypeQrCodeAuthentication extends InternalLinkType {
  String get tdType => 'internalLinkTypeQrCodeAuthentication';


  InternalLinkTypeQrCodeAuthentication({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeQrCodeAuthentication.fromMap(Map<String, dynamic> map) {
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

/// The link is a link to app settings
class InternalLinkTypeSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeSettings';


  InternalLinkTypeSettings({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeSettings.fromMap(Map<String, dynamic> map) {
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

/// The link is a link to a sticker set. Call searchStickerSet with the given sticker set name to process the link and show the sticker set 
class InternalLinkTypeStickerSet extends InternalLinkType {
  String get tdType => 'internalLinkTypeStickerSet';


  /// Name of the sticker set
  string? sticker_set_name;

  InternalLinkTypeStickerSet({
    super.extra,
    super.client_id,
    this.sticker_set_name,
  });

  InternalLinkTypeStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker_set_name = map['sticker_set_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_set_name': sticker_set_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to a theme. TDLib has no theme support yet 
class InternalLinkTypeTheme extends InternalLinkType {
  String get tdType => 'internalLinkTypeTheme';


  /// Name of the theme
  string? theme_name;

  InternalLinkTypeTheme({
    super.extra,
    super.client_id,
    this.theme_name,
  });

  InternalLinkTypeTheme.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    theme_name = map['theme_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'theme_name': theme_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The link is a link to the theme settings section of the app
class InternalLinkTypeThemeSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeThemeSettings';


  InternalLinkTypeThemeSettings({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeThemeSettings.fromMap(Map<String, dynamic> map) {
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

/// The link is an unknown tg: link. Call getDeepLinkInfo to process the link 
class InternalLinkTypeUnknownDeepLink extends InternalLinkType {
  String get tdType => 'internalLinkTypeUnknownDeepLink';


  /// Link to be passed to getDeepLinkInfo
  string? link;

  InternalLinkTypeUnknownDeepLink({
    super.extra,
    super.client_id,
    this.link,
  });

  InternalLinkTypeUnknownDeepLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    link = map['link'];
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

/// The link is a link to an unsupported proxy. An alert can be shown to the user
class InternalLinkTypeUnsupportedProxy extends InternalLinkType {
  String get tdType => 'internalLinkTypeUnsupportedProxy';


  InternalLinkTypeUnsupportedProxy({
    super.extra,
    super.client_id,
  });

  InternalLinkTypeUnsupportedProxy.fromMap(Map<String, dynamic> map) {
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

/// The link is a link to a video chat. Call searchPublicChat with the given chat username, and then joinGoupCall with the given invite hash to process the link
class InternalLinkTypeVideoChat extends InternalLinkType {
  String get tdType => 'internalLinkTypeVideoChat';


  /// Username of the chat with the video chat 
  string? chat_username;

  /// If non-empty, invite hash to be used to join the video chat without being muted by administrators
  string? invite_hash;

  /// True, if the video chat is expected to be a live stream in a channel or a broadcast group
  Bool? is_live_stream;

  InternalLinkTypeVideoChat({
    super.extra,
    super.client_id,
    this.chat_username,
    this.invite_hash,
    this.is_live_stream,
  });

  InternalLinkTypeVideoChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_username = map['chat_username'];
    invite_hash = map['invite_hash'];
    is_live_stream = map['is_live_stream'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_username': chat_username?.toMap(skipNulls: skipNulls),
      'invite_hash': invite_hash?.toMap(skipNulls: skipNulls),
      'is_live_stream': is_live_stream?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
