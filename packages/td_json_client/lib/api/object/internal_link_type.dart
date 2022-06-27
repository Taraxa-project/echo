import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_administrator_rights.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/proxy_type.dart';

abstract class InternalLinkType extends TdObject {}

class InternalLinkTypeActiveSessions extends InternalLinkType {
  String get tdType => 'internalLinkTypeActiveSessions';

  string? extra;
  int? client_id;

  InternalLinkTypeActiveSessions({
    this.extra,
    this.client_id,
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
class InternalLinkTypeAttachmentMenuBot extends InternalLinkType {
  String get tdType => 'internalLinkTypeAttachmentMenuBot';

  string? extra;
  int? client_id;
  InternalLinkType? chat_link;
  string? bot_username;
  string? url;

  InternalLinkTypeAttachmentMenuBot({
    this.extra,
    this.client_id,
    this.chat_link,
    this.bot_username,
    this.url,
  });

  InternalLinkTypeAttachmentMenuBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_link = map['chat_link'];
    bot_username = map['bot_username'];
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_link': chat_link?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InternalLinkTypeAuthenticationCode extends InternalLinkType {
  String get tdType => 'internalLinkTypeAuthenticationCode';

  string? extra;
  int? client_id;
  string? code;

  InternalLinkTypeAuthenticationCode({
    this.extra,
    this.client_id,
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
class InternalLinkTypeBackground extends InternalLinkType {
  String get tdType => 'internalLinkTypeBackground';

  string? extra;
  int? client_id;
  string? background_name;

  InternalLinkTypeBackground({
    this.extra,
    this.client_id,
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
class InternalLinkTypeBotStart extends InternalLinkType {
  String get tdType => 'internalLinkTypeBotStart';

  string? extra;
  int? client_id;
  string? bot_username;
  string? start_parameter;

  InternalLinkTypeBotStart({
    this.extra,
    this.client_id,
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
class InternalLinkTypeBotStartInGroup extends InternalLinkType {
  String get tdType => 'internalLinkTypeBotStartInGroup';

  string? extra;
  int? client_id;
  string? bot_username;
  string? start_parameter;
  ChatAdministratorRights? administrator_rights;

  InternalLinkTypeBotStartInGroup({
    this.extra,
    this.client_id,
    this.bot_username,
    this.start_parameter,
    this.administrator_rights,
  });

  InternalLinkTypeBotStartInGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_username = map['bot_username'];
    start_parameter = map['start_parameter'];
    administrator_rights = TdApiMap.fromMap(map['administrator_rights']) as ChatAdministratorRights;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
      'administrator_rights': administrator_rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InternalLinkTypeBotAddToChannel extends InternalLinkType {
  String get tdType => 'internalLinkTypeBotAddToChannel';

  string? extra;
  int? client_id;
  string? bot_username;
  ChatAdministratorRights? administrator_rights;

  InternalLinkTypeBotAddToChannel({
    this.extra,
    this.client_id,
    this.bot_username,
    this.administrator_rights,
  });

  InternalLinkTypeBotAddToChannel.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_username = map['bot_username'];
    administrator_rights = TdApiMap.fromMap(map['administrator_rights']) as ChatAdministratorRights;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_username': bot_username?.toMap(skipNulls: skipNulls),
      'administrator_rights': administrator_rights?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InternalLinkTypeChangePhoneNumber extends InternalLinkType {
  String get tdType => 'internalLinkTypeChangePhoneNumber';

  string? extra;
  int? client_id;

  InternalLinkTypeChangePhoneNumber({
    this.extra,
    this.client_id,
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
class InternalLinkTypeChatInvite extends InternalLinkType {
  String get tdType => 'internalLinkTypeChatInvite';

  string? extra;
  int? client_id;
  string? invite_link;

  InternalLinkTypeChatInvite({
    this.extra,
    this.client_id,
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
class InternalLinkTypeFilterSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeFilterSettings';

  string? extra;
  int? client_id;

  InternalLinkTypeFilterSettings({
    this.extra,
    this.client_id,
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
class InternalLinkTypeGame extends InternalLinkType {
  String get tdType => 'internalLinkTypeGame';

  string? extra;
  int? client_id;
  string? bot_username;
  string? game_short_name;

  InternalLinkTypeGame({
    this.extra,
    this.client_id,
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
class InternalLinkTypeLanguagePack extends InternalLinkType {
  String get tdType => 'internalLinkTypeLanguagePack';

  string? extra;
  int? client_id;
  string? language_pack_id;

  InternalLinkTypeLanguagePack({
    this.extra,
    this.client_id,
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
class InternalLinkTypeLanguageSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeLanguageSettings';

  string? extra;
  int? client_id;

  InternalLinkTypeLanguageSettings({
    this.extra,
    this.client_id,
  });

  InternalLinkTypeLanguageSettings.fromMap(Map<String, dynamic> map) {
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
class InternalLinkTypeMessage extends InternalLinkType {
  String get tdType => 'internalLinkTypeMessage';

  string? extra;
  int? client_id;
  string? url;

  InternalLinkTypeMessage({
    this.extra,
    this.client_id,
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
class InternalLinkTypeMessageDraft extends InternalLinkType {
  String get tdType => 'internalLinkTypeMessageDraft';

  string? extra;
  int? client_id;
  FormattedText? text;
  Bool? contains_link;

  InternalLinkTypeMessageDraft({
    this.extra,
    this.client_id,
    this.text,
    this.contains_link,
  });

  InternalLinkTypeMessageDraft.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
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
class InternalLinkTypePassportDataRequest extends InternalLinkType {
  String get tdType => 'internalLinkTypePassportDataRequest';

  string? extra;
  int? client_id;
  int53? bot_user_id;
  string? scope;
  string? public_key;
  string? nonce;
  string? callback_url;

  InternalLinkTypePassportDataRequest({
    this.extra,
    this.client_id,
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
class InternalLinkTypePhoneNumberConfirmation extends InternalLinkType {
  String get tdType => 'internalLinkTypePhoneNumberConfirmation';

  string? extra;
  int? client_id;
  string? hash;
  string? phone_number;

  InternalLinkTypePhoneNumberConfirmation({
    this.extra,
    this.client_id,
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
class InternalLinkTypePrivacyAndSecuritySettings extends InternalLinkType {
  String get tdType => 'internalLinkTypePrivacyAndSecuritySettings';

  string? extra;
  int? client_id;

  InternalLinkTypePrivacyAndSecuritySettings({
    this.extra,
    this.client_id,
  });

  InternalLinkTypePrivacyAndSecuritySettings.fromMap(Map<String, dynamic> map) {
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
class InternalLinkTypeProxy extends InternalLinkType {
  String get tdType => 'internalLinkTypeProxy';

  string? extra;
  int? client_id;
  string? server;
  int32? port;
  ProxyType? type;

  InternalLinkTypeProxy({
    this.extra,
    this.client_id,
    this.server,
    this.port,
    this.type,
  });

  InternalLinkTypeProxy.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    server = map['server'];
    port = map['port'];
    type = TdApiMap.fromMap(map['type']) as ProxyType;
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
class InternalLinkTypePublicChat extends InternalLinkType {
  String get tdType => 'internalLinkTypePublicChat';

  string? extra;
  int? client_id;
  string? chat_username;

  InternalLinkTypePublicChat({
    this.extra,
    this.client_id,
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
class InternalLinkTypeQrCodeAuthentication extends InternalLinkType {
  String get tdType => 'internalLinkTypeQrCodeAuthentication';

  string? extra;
  int? client_id;

  InternalLinkTypeQrCodeAuthentication({
    this.extra,
    this.client_id,
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
class InternalLinkTypeSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeSettings';

  string? extra;
  int? client_id;

  InternalLinkTypeSettings({
    this.extra,
    this.client_id,
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
class InternalLinkTypeStickerSet extends InternalLinkType {
  String get tdType => 'internalLinkTypeStickerSet';

  string? extra;
  int? client_id;
  string? sticker_set_name;

  InternalLinkTypeStickerSet({
    this.extra,
    this.client_id,
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
class InternalLinkTypeTheme extends InternalLinkType {
  String get tdType => 'internalLinkTypeTheme';

  string? extra;
  int? client_id;
  string? theme_name;

  InternalLinkTypeTheme({
    this.extra,
    this.client_id,
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
class InternalLinkTypeThemeSettings extends InternalLinkType {
  String get tdType => 'internalLinkTypeThemeSettings';

  string? extra;
  int? client_id;

  InternalLinkTypeThemeSettings({
    this.extra,
    this.client_id,
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
class InternalLinkTypeUnknownDeepLink extends InternalLinkType {
  String get tdType => 'internalLinkTypeUnknownDeepLink';

  string? extra;
  int? client_id;
  string? link;

  InternalLinkTypeUnknownDeepLink({
    this.extra,
    this.client_id,
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
class InternalLinkTypeUnsupportedProxy extends InternalLinkType {
  String get tdType => 'internalLinkTypeUnsupportedProxy';

  string? extra;
  int? client_id;

  InternalLinkTypeUnsupportedProxy({
    this.extra,
    this.client_id,
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
class InternalLinkTypeUserPhoneNumber extends InternalLinkType {
  String get tdType => 'internalLinkTypeUserPhoneNumber';

  string? extra;
  int? client_id;
  string? phone_number;

  InternalLinkTypeUserPhoneNumber({
    this.extra,
    this.client_id,
    this.phone_number,
  });

  InternalLinkTypeUserPhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InternalLinkTypeVideoChat extends InternalLinkType {
  String get tdType => 'internalLinkTypeVideoChat';

  string? extra;
  int? client_id;
  string? chat_username;
  string? invite_hash;
  Bool? is_live_stream;

  InternalLinkTypeVideoChat({
    this.extra,
    this.client_id,
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
