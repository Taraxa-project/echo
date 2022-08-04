import 'package:td_json_client/api/base.dart';

/// Represents the type of a user. The following types are possible: regular users, deleted users and bots
abstract class UserType extends TdObject {
  UserType({super.extra, super.client_id});
}


/// A regular user
class UserTypeRegular extends UserType {
  String get tdType => 'userTypeRegular';


  UserTypeRegular({
    super.extra,
    super.client_id,
  });

  UserTypeRegular.fromMap(Map<String, dynamic> map) {
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

/// A deleted user or deleted bot. No information on the user besides the user identifier is available. It is not possible to perform any active actions on this type of user
class UserTypeDeleted extends UserType {
  String get tdType => 'userTypeDeleted';


  UserTypeDeleted({
    super.extra,
    super.client_id,
  });

  UserTypeDeleted.fromMap(Map<String, dynamic> map) {
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

/// A bot (see https://core.telegram.org/bots)
class UserTypeBot extends UserType {
  String get tdType => 'userTypeBot';


  /// True, if the bot can be invited to basic group and supergroup chats
  Bool? can_join_groups;

  /// True, if the bot can read all messages in basic group or supergroup chats and not just those addressed to the bot. In private and channel chats a bot can always read all messages
  Bool? can_read_all_group_messages;

  /// True, if the bot supports inline queries
  Bool? is_inline;

  /// Placeholder for inline queries (displayed on the application input field)
  string? inline_query_placeholder;

  /// True, if the location of the user is expected to be sent with every inline query to this bot
  Bool? need_location;

  /// True, if the bot can be added to attachment menu
  Bool? can_be_added_to_attachment_menu;

  UserTypeBot({
    super.extra,
    super.client_id,
    this.can_join_groups,
    this.can_read_all_group_messages,
    this.is_inline,
    this.inline_query_placeholder,
    this.need_location,
    this.can_be_added_to_attachment_menu,
  });

  UserTypeBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_join_groups = map['can_join_groups'];
    can_read_all_group_messages = map['can_read_all_group_messages'];
    is_inline = map['is_inline'];
    inline_query_placeholder = map['inline_query_placeholder'];
    need_location = map['need_location'];
    can_be_added_to_attachment_menu = map['can_be_added_to_attachment_menu'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_join_groups': can_join_groups?.toMap(skipNulls: skipNulls),
      'can_read_all_group_messages': can_read_all_group_messages?.toMap(skipNulls: skipNulls),
      'is_inline': is_inline?.toMap(skipNulls: skipNulls),
      'inline_query_placeholder': inline_query_placeholder?.toMap(skipNulls: skipNulls),
      'need_location': need_location?.toMap(skipNulls: skipNulls),
      'can_be_added_to_attachment_menu': can_be_added_to_attachment_menu?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// No information on the user besides the user identifier is available, yet this user has not been deleted. This object is extremely rare and must be handled like a deleted user. It is not possible to perform any actions on users of this type
class UserTypeUnknown extends UserType {
  String get tdType => 'userTypeUnknown';


  UserTypeUnknown({
    super.extra,
    super.client_id,
  });

  UserTypeUnknown.fromMap(Map<String, dynamic> map) {
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
