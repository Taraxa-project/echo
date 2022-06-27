import 'package:td_json_client/api/base.dart';

abstract class ChatActionBar extends TdObject {}

class ChatActionBarReportSpam extends ChatActionBar {
  String get tdType => 'chatActionBarReportSpam';

  String? extra;
  int? client_id;
  Bool? can_unarchive;

  ChatActionBarReportSpam({
    this.extra,
    this.client_id,
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
class ChatActionBarReportUnrelatedLocation extends ChatActionBar {
  String get tdType => 'chatActionBarReportUnrelatedLocation';

  String? extra;
  int? client_id;

  ChatActionBarReportUnrelatedLocation({
    this.extra,
    this.client_id,
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
class ChatActionBarInviteMembers extends ChatActionBar {
  String get tdType => 'chatActionBarInviteMembers';

  String? extra;
  int? client_id;

  ChatActionBarInviteMembers({
    this.extra,
    this.client_id,
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
class ChatActionBarReportAddBlock extends ChatActionBar {
  String get tdType => 'chatActionBarReportAddBlock';

  String? extra;
  int? client_id;
  Bool? can_unarchive;
  int32? distance;

  ChatActionBarReportAddBlock({
    this.extra,
    this.client_id,
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
class ChatActionBarAddContact extends ChatActionBar {
  String get tdType => 'chatActionBarAddContact';

  String? extra;
  int? client_id;

  ChatActionBarAddContact({
    this.extra,
    this.client_id,
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
class ChatActionBarSharePhoneNumber extends ChatActionBar {
  String get tdType => 'chatActionBarSharePhoneNumber';

  String? extra;
  int? client_id;

  ChatActionBarSharePhoneNumber({
    this.extra,
    this.client_id,
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
class ChatActionBarJoinRequest extends ChatActionBar {
  String get tdType => 'chatActionBarJoinRequest';

  String? extra;
  int? client_id;
  string? title;
  Bool? is_channel;
  int32? request_date;

  ChatActionBarJoinRequest({
    this.extra,
    this.client_id,
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
