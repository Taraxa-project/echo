import 'package:td_json_client/api/base.dart';

/// Specifies the kind of chat members to return in getSupergroupMembers
abstract class SupergroupMembersFilter extends TdObject {}


/// Returns recently active users in reverse chronological order
class SupergroupMembersFilterRecent extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterRecent';

  String? extra;
  int? client_id;

  SupergroupMembersFilterRecent({
    this.extra,
    this.client_id,
  });

  SupergroupMembersFilterRecent.fromMap(Map<String, dynamic> map) {
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

/// Returns contacts of the user, which are members of the supergroup or channel 
class SupergroupMembersFilterContacts extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterContacts';

  String? extra;
  int? client_id;

  /// Query to search for
  string? query;

  SupergroupMembersFilterContacts({
    this.extra,
    this.client_id,
    this.query,
  });

  SupergroupMembersFilterContacts.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Returns the owner and administrators
class SupergroupMembersFilterAdministrators extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterAdministrators';

  String? extra;
  int? client_id;

  SupergroupMembersFilterAdministrators({
    this.extra,
    this.client_id,
  });

  SupergroupMembersFilterAdministrators.fromMap(Map<String, dynamic> map) {
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

/// Used to search for supergroup or channel members via a (string) query 
class SupergroupMembersFilterSearch extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterSearch';

  String? extra;
  int? client_id;

  /// Query to search for
  string? query;

  SupergroupMembersFilterSearch({
    this.extra,
    this.client_id,
    this.query,
  });

  SupergroupMembersFilterSearch.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Returns restricted supergroup members; can be used only by administrators 
class SupergroupMembersFilterRestricted extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterRestricted';

  String? extra;
  int? client_id;

  /// Query to search for
  string? query;

  SupergroupMembersFilterRestricted({
    this.extra,
    this.client_id,
    this.query,
  });

  SupergroupMembersFilterRestricted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Returns users banned from the supergroup or channel; can be used only by administrators 
class SupergroupMembersFilterBanned extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterBanned';

  String? extra;
  int? client_id;

  /// Query to search for
  string? query;

  SupergroupMembersFilterBanned({
    this.extra,
    this.client_id,
    this.query,
  });

  SupergroupMembersFilterBanned.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Returns users which can be mentioned in the supergroup 
class SupergroupMembersFilterMention extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterMention';

  String? extra;
  int? client_id;

  /// Query to search for 
  string? query;

  /// If non-zero, the identifier of the current message thread
  int53? message_thread_id;

  SupergroupMembersFilterMention({
    this.extra,
    this.client_id,
    this.query,
    this.message_thread_id,
  });

  SupergroupMembersFilterMention.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    query = map['query'];
    message_thread_id = map['message_thread_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'query': query?.toMap(skipNulls: skipNulls),
      'message_thread_id': message_thread_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Returns bot members of the supergroup or channel
class SupergroupMembersFilterBots extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterBots';

  String? extra;
  int? client_id;

  SupergroupMembersFilterBots({
    this.extra,
    this.client_id,
  });

  SupergroupMembersFilterBots.fromMap(Map<String, dynamic> map) {
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
