import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_administrator_rights.dart';

/// Describes a keyboard button type
abstract class KeyboardButtonType extends TdObject {
  KeyboardButtonType({super.extra, super.client_id});
}

/// A simple button, with text that must be sent when the button is pressed
class KeyboardButtonTypeText extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeText';

  KeyboardButtonTypeText({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeText.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's phone number when pressed; available only in private chats
class KeyboardButtonTypeRequestPhoneNumber extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPhoneNumber';

  KeyboardButtonTypeRequestPhoneNumber({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeRequestPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A button that sends the user's location when pressed; available only in private chats
class KeyboardButtonTypeRequestLocation extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestLocation';

  KeyboardButtonTypeRequestLocation({
    super.extra,
    super.client_id,
  });

  KeyboardButtonTypeRequestLocation.fromMap(Map<String, dynamic> map) {
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

/// A button that allows the user to create and send a poll when pressed; available only in private chats
class KeyboardButtonTypeRequestPoll extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestPoll';

  /// If true, only regular polls must be allowed to create
  Bool? force_regular;

  /// If true, only polls in quiz mode must be allowed to create
  Bool? force_quiz;

  KeyboardButtonTypeRequestPoll({
    super.extra,
    super.client_id,
    this.force_regular,
    this.force_quiz,
  });

  KeyboardButtonTypeRequestPoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    force_regular = map['force_regular'];
    force_quiz = map['force_quiz'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'force_regular': force_regular?.toMap(skipNulls: skipNulls),
      'force_quiz': force_quiz?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that requests a user to be shared by the current user; available only in private chats. Use the method shareUserWithBot to complete the request
class KeyboardButtonTypeRequestUser extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestUser';

  /// Unique button identifier
  int32? id;

  /// True, if the shared user must or must not be a bot
  Bool? restrict_user_is_bot;

  /// True, if the shared user must be a bot; otherwise, the shared user must no be a bot. Ignored if restrict_user_is_bot is false
  Bool? user_is_bot;

  /// True, if the shared user must or must not be a Telegram Premium user
  Bool? restrict_user_is_premium;

  /// True, if the shared user must be a Telegram Premium user; otherwise, the shared user must no be a Telegram Premium user. Ignored if restrict_user_is_premium is false
  Bool? user_is_premium;

  KeyboardButtonTypeRequestUser({
    super.extra,
    super.client_id,
    this.id,
    this.restrict_user_is_bot,
    this.user_is_bot,
    this.restrict_user_is_premium,
    this.user_is_premium,
  });

  KeyboardButtonTypeRequestUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    restrict_user_is_bot = map['restrict_user_is_bot'];
    user_is_bot = map['user_is_bot'];
    restrict_user_is_premium = map['restrict_user_is_premium'];
    user_is_premium = map['user_is_premium'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'restrict_user_is_bot': restrict_user_is_bot?.toMap(skipNulls: skipNulls),
      'user_is_bot': user_is_bot?.toMap(skipNulls: skipNulls),
      'restrict_user_is_premium': restrict_user_is_premium?.toMap(skipNulls: skipNulls),
      'user_is_premium': user_is_premium?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that requests a chat to be shared by the current user; available only in private chats. Use the method shareChatWithBot to complete the request
class KeyboardButtonTypeRequestChat extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeRequestChat';

  /// Unique button identifier
  int32? id;

  /// True, if the chat must be a channel; otherwise, a basic group or a supergroup chat is shared
  Bool? chat_is_channel;

  /// True, if the chat must or must not be a forum supergroup
  Bool? restrict_chat_is_forum;

  /// True, if the chat must be a forum supergroup; otherwise, the chat must not be a forum supergroup. Ignored if restrict_chat_is_forum is false
  Bool? chat_is_forum;

  /// True, if the chat must or must not have a username
  Bool? restrict_chat_has_username;

  /// True, if the chat must have a username; otherwise, the chat must not have a username. Ignored if restrict_chat_has_username is false
  Bool? chat_has_username;

  /// True, if the chat must be created by the current user
  Bool? chat_is_created;

  /// Expected user administrator rights in the chat; may be null if they aren't restricted
  ChatAdministratorRights? user_administrator_rights;

  /// Expected bot administrator rights in the chat; may be null if they aren't restricted
  ChatAdministratorRights? bot_administrator_rights;

  /// True, if the bot must be a member of the chat; for basic group and supergroup chats only
  Bool? bot_is_member;

  KeyboardButtonTypeRequestChat({
    super.extra,
    super.client_id,
    this.id,
    this.chat_is_channel,
    this.restrict_chat_is_forum,
    this.chat_is_forum,
    this.restrict_chat_has_username,
    this.chat_has_username,
    this.chat_is_created,
    this.user_administrator_rights,
    this.bot_administrator_rights,
    this.bot_is_member,
  });

  KeyboardButtonTypeRequestChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    chat_is_channel = map['chat_is_channel'];
    restrict_chat_is_forum = map['restrict_chat_is_forum'];
    chat_is_forum = map['chat_is_forum'];
    restrict_chat_has_username = map['restrict_chat_has_username'];
    chat_has_username = map['chat_has_username'];
    chat_is_created = map['chat_is_created'];
    if (map['user_administrator_rights'] != null) {
      user_administrator_rights = TdApiMap.fromMap(map['user_administrator_rights']) as ChatAdministratorRights;
    }
    if (map['bot_administrator_rights'] != null) {
      bot_administrator_rights = TdApiMap.fromMap(map['bot_administrator_rights']) as ChatAdministratorRights;
    }
    bot_is_member = map['bot_is_member'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'chat_is_channel': chat_is_channel?.toMap(skipNulls: skipNulls),
      'restrict_chat_is_forum': restrict_chat_is_forum?.toMap(skipNulls: skipNulls),
      'chat_is_forum': chat_is_forum?.toMap(skipNulls: skipNulls),
      'restrict_chat_has_username': restrict_chat_has_username?.toMap(skipNulls: skipNulls),
      'chat_has_username': chat_has_username?.toMap(skipNulls: skipNulls),
      'chat_is_created': chat_is_created?.toMap(skipNulls: skipNulls),
      'user_administrator_rights': user_administrator_rights?.toMap(skipNulls: skipNulls),
      'bot_administrator_rights': bot_administrator_rights?.toMap(skipNulls: skipNulls),
      'bot_is_member': bot_is_member?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A button that opens a Web App by calling getWebAppUrl
class KeyboardButtonTypeWebApp extends KeyboardButtonType {
  String get tdType => 'keyboardButtonTypeWebApp';

  /// An HTTP URL to pass to getWebAppUrl
  string? url;

  KeyboardButtonTypeWebApp({
    super.extra,
    super.client_id,
    this.url,
  });

  KeyboardButtonTypeWebApp.fromMap(Map<String, dynamic> map) {
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
