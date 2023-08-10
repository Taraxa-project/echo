import 'package:td_json_client/src/td_api/td.dart';

/// Contains settings for automatic moving of chats to and from the Archive chat lists
class ArchiveChatListSettings extends TdObject {
  String get tdType => 'archiveChatListSettings';

  /// True, if new chats from non-contacts will be automatically archived and muted. Can be set to true only if the option "can_archive_and_mute_new_chats_from_unknown_users" is true
  Bool? archive_and_mute_new_chats_from_unknown_users;

  /// True, if unmuted chats will be kept in the Archive chat list when they get a new message
  Bool? keep_unmuted_chats_archived;

  /// True, if unmuted chats, that are always included or pinned in a folder, will be kept in the Archive chat list when they get a new message. Ignored if keep_unmuted_chats_archived == true
  Bool? keep_chats_from_folders_archived;

  ArchiveChatListSettings({
    super.extra,
    super.client_id,
    this.archive_and_mute_new_chats_from_unknown_users,
    this.keep_unmuted_chats_archived,
    this.keep_chats_from_folders_archived,
  });

  ArchiveChatListSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    archive_and_mute_new_chats_from_unknown_users = map['archive_and_mute_new_chats_from_unknown_users'];
    keep_unmuted_chats_archived = map['keep_unmuted_chats_archived'];
    keep_chats_from_folders_archived = map['keep_chats_from_folders_archived'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'archive_and_mute_new_chats_from_unknown_users': archive_and_mute_new_chats_from_unknown_users?.toMap(skipNulls: skipNulls),
      'keep_unmuted_chats_archived': keep_unmuted_chats_archived?.toMap(skipNulls: skipNulls),
      'keep_chats_from_folders_archived': keep_chats_from_folders_archived?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
