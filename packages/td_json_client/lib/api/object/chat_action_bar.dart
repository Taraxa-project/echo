import 'package:td_json_client/api/base.dart';

/// Describes actions which must be possible to do through a chat action bar
abstract class ChatActionBar extends TdObject {
  ChatActionBar({super.extra, super.client_id});
}


/// The chat can be reported as spam using the method reportChat with the reason chatReportReasonSpam. If the chat is a private chat with a user with an emoji status, then a notice about emoji status usage must be shown
class ChatActionBarReportSpam extends ChatActionBar {
  String get tdType => 'chatActionBarReportSpam';


  /// If true, the chat was automatically archived and can be moved back to the main chat list using addChatToList simultaneously with setting chat notification settings to default using setChatNotificationSettings
  Bool? can_unarchive;

  ChatActionBarReportSpam({
    super.extra,
    super.client_id,
    this.can_unarchive,
  });

  ChatActionBarReportSpam.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_unarchive = map['can_unarchive'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_unarchive': can_unarchive?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat is a location-based supergroup, which can be reported as having unrelated location using the method reportChat with the reason chatReportReasonUnrelatedLocation
class ChatActionBarReportUnrelatedLocation extends ChatActionBar {
  String get tdType => 'chatActionBarReportUnrelatedLocation';


  ChatActionBarReportUnrelatedLocation({
    super.extra,
    super.client_id,
  });

  ChatActionBarReportUnrelatedLocation.fromMap(Map<String, dynamic> map) {
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

/// The chat is a recently created group chat to which new members can be invited
class ChatActionBarInviteMembers extends ChatActionBar {
  String get tdType => 'chatActionBarInviteMembers';


  ChatActionBarInviteMembers({
    super.extra,
    super.client_id,
  });

  ChatActionBarInviteMembers.fromMap(Map<String, dynamic> map) {
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

/// The chat is a private or secret chat, which can be reported using the method reportChat, or the other user can be blocked using the method toggleMessageSenderIsBlocked,
/// or the other user can be added to the contact list using the method addContact. If the chat is a private chat with a user with an emoji status, then a notice about emoji status usage must be shown
class ChatActionBarReportAddBlock extends ChatActionBar {
  String get tdType => 'chatActionBarReportAddBlock';


  /// If true, the chat was automatically archived and can be moved back to the main chat list using addChatToList simultaneously with setting chat notification settings to default using setChatNotificationSettings
  Bool? can_unarchive;

  /// If non-negative, the current user was found by the peer through searchChatsNearby and this is the distance between the users
  int32? distance;

  ChatActionBarReportAddBlock({
    super.extra,
    super.client_id,
    this.can_unarchive,
    this.distance,
  });

  ChatActionBarReportAddBlock.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_unarchive = map['can_unarchive'];
    distance = map['distance'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_unarchive': can_unarchive?.toMap(skipNulls: skipNulls),
      'distance': distance?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The chat is a private or secret chat and the other user can be added to the contact list using the method addContact
class ChatActionBarAddContact extends ChatActionBar {
  String get tdType => 'chatActionBarAddContact';


  ChatActionBarAddContact({
    super.extra,
    super.client_id,
  });

  ChatActionBarAddContact.fromMap(Map<String, dynamic> map) {
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

/// The chat is a private or secret chat with a mutual contact and the user's phone number can be shared with the other user using the method sharePhoneNumber
class ChatActionBarSharePhoneNumber extends ChatActionBar {
  String get tdType => 'chatActionBarSharePhoneNumber';


  ChatActionBarSharePhoneNumber({
    super.extra,
    super.client_id,
  });

  ChatActionBarSharePhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// The chat is a private chat with an administrator of a chat to which the user sent join request
class ChatActionBarJoinRequest extends ChatActionBar {
  String get tdType => 'chatActionBarJoinRequest';


  /// Title of the chat to which the join request was sent
  string? title;

  /// True, if the join request was sent to a channel chat
  Bool? is_channel;

  /// Point in time (Unix timestamp) when the join request was sent
  int32? request_date;

  ChatActionBarJoinRequest({
    super.extra,
    super.client_id,
    this.title,
    this.is_channel,
    this.request_date,
  });

  ChatActionBarJoinRequest.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    is_channel = map['is_channel'];
    request_date = map['request_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'is_channel': is_channel?.toMap(skipNulls: skipNulls),
      'request_date': request_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
