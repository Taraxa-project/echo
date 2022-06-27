import 'package:td_json_client/api/base.dart';

abstract class UserType extends TdObject {}

class UserTypeRegular extends UserType {
  String get tdType => 'userTypeRegular';

  String? extra;
  int? client_id;

  UserTypeRegular({
    this.extra,
    this.client_id,
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
class UserTypeDeleted extends UserType {
  String get tdType => 'userTypeDeleted';

  String? extra;
  int? client_id;

  UserTypeDeleted({
    this.extra,
    this.client_id,
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
class UserTypeBot extends UserType {
  String get tdType => 'userTypeBot';

  String? extra;
  int? client_id;
  Bool? can_join_groups;
  Bool? can_read_all_group_messages;
  Bool? is_inline;
  string? inline_query_placeholder;
  Bool? need_location;
  Bool? can_be_added_to_attachment_menu;

  UserTypeBot({
    this.extra,
    this.client_id,
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
class UserTypeUnknown extends UserType {
  String get tdType => 'userTypeUnknown';

  String? extra;
  int? client_id;

  UserTypeUnknown({
    this.extra,
    this.client_id,
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
