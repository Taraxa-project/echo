import 'package:td_json_client/api/base.dart';


/// Represents a filter of user chats
class ChatFilter extends TdObject {
  String get tdType => 'chatFilter';


  /// The title of the filter; 1-12 characters without line feeds
  string? title;

  /// The chosen icon name for short filter representation. If non-empty, must be one of "All", "Unread", "Unmuted", "Bots", "Channels", "Groups", "Private", "Custom", "Setup", "Cat", "Crown", "Favorite", "Flower", "Game", "Home", "Love", "Mask", "Party", "Sport", "Study", "Trade", "Travel", "Work".
  /// If empty, use getChatFilterDefaultIconName to get default icon name for the filter
  string? icon_name;

  /// The chat identifiers of pinned chats in the filtered chat list
  vector<int53>? pinned_chat_ids;

  /// The chat identifiers of always included chats in the filtered chat list
  vector<int53>? included_chat_ids;

  /// The chat identifiers of always excluded chats in the filtered chat list
  vector<int53>? excluded_chat_ids;

  /// True, if muted chats need to be excluded
  Bool? exclude_muted;

  /// True, if read chats need to be excluded
  Bool? exclude_read;

  /// True, if archived chats need to be excluded
  Bool? exclude_archived;

  /// True, if contacts need to be included
  Bool? include_contacts;

  /// True, if non-contact users need to be included
  Bool? include_non_contacts;

  /// True, if bots need to be included
  Bool? include_bots;

  /// True, if basic groups and supergroups need to be included
  Bool? include_groups;

  /// True, if channels need to be included
  Bool? include_channels;

  ChatFilter({
    super.extra,
    super.client_id,
    this.title,
    this.icon_name,
    this.pinned_chat_ids,
    this.included_chat_ids,
    this.excluded_chat_ids,
    this.exclude_muted,
    this.exclude_read,
    this.exclude_archived,
    this.include_contacts,
    this.include_non_contacts,
    this.include_bots,
    this.include_groups,
    this.include_channels,
  });

  ChatFilter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    icon_name = map['icon_name'];
    if (map['pinned_chat_ids'] != null) {
      pinned_chat_ids = [];
      for (var someValue in map['pinned_chat_ids']) {
        pinned_chat_ids?.add(someValue);
      }
    }
    if (map['included_chat_ids'] != null) {
      included_chat_ids = [];
      for (var someValue in map['included_chat_ids']) {
        included_chat_ids?.add(someValue);
      }
    }
    if (map['excluded_chat_ids'] != null) {
      excluded_chat_ids = [];
      for (var someValue in map['excluded_chat_ids']) {
        excluded_chat_ids?.add(someValue);
      }
    }
    exclude_muted = map['exclude_muted'];
    exclude_read = map['exclude_read'];
    exclude_archived = map['exclude_archived'];
    include_contacts = map['include_contacts'];
    include_non_contacts = map['include_non_contacts'];
    include_bots = map['include_bots'];
    include_groups = map['include_groups'];
    include_channels = map['include_channels'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'icon_name': icon_name?.toMap(skipNulls: skipNulls),
      'pinned_chat_ids': pinned_chat_ids?.toMap(skipNulls: skipNulls),
      'included_chat_ids': included_chat_ids?.toMap(skipNulls: skipNulls),
      'excluded_chat_ids': excluded_chat_ids?.toMap(skipNulls: skipNulls),
      'exclude_muted': exclude_muted?.toMap(skipNulls: skipNulls),
      'exclude_read': exclude_read?.toMap(skipNulls: skipNulls),
      'exclude_archived': exclude_archived?.toMap(skipNulls: skipNulls),
      'include_contacts': include_contacts?.toMap(skipNulls: skipNulls),
      'include_non_contacts': include_non_contacts?.toMap(skipNulls: skipNulls),
      'include_bots': include_bots?.toMap(skipNulls: skipNulls),
      'include_groups': include_groups?.toMap(skipNulls: skipNulls),
      'include_channels': include_channels?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
