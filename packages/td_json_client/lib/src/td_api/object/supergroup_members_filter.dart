import 'package:td_json_client/src/td_api/td.dart';

/// Specifies the kind of chat members to return in getSupergroupMembers
abstract class SupergroupMembersFilter extends TdObject {
  SupergroupMembersFilter({super.extra, super.client_id});
}

/// Returns recently active users in reverse chronological order
class SupergroupMembersFilterRecent extends SupergroupMembersFilter {
  String get tdType => 'supergroupMembersFilterRecent';

  SupergroupMembersFilterRecent({
    super.extra,
    super.client_id,
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

  /// Query to search for
  string? query;

  SupergroupMembersFilterContacts({
    super.extra,
    super.client_id,
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

  SupergroupMembersFilterAdministrators({
    super.extra,
    super.client_id,
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

  /// Query to search for
  string? query;

  SupergroupMembersFilterSearch({
    super.extra,
    super.client_id,
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

  /// Query to search for
  string? query;

  SupergroupMembersFilterRestricted({
    super.extra,
    super.client_id,
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

  /// Query to search for
  string? query;

  SupergroupMembersFilterBanned({
    super.extra,
    super.client_id,
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

  /// Query to search for
  string? query;

  /// If non-zero, the identifier of the current message thread
  int53? message_thread_id;

  SupergroupMembersFilterMention({
    super.extra,
    super.client_id,
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

  SupergroupMembersFilterBots({
    super.extra,
    super.client_id,
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
