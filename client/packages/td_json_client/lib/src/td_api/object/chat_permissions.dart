import 'package:td_json_client/src/td_api/td.dart';

/// Describes actions that a user is allowed to take in a chat
class ChatPermissions extends TdObject {
  String get tdType => 'chatPermissions';

  /// True, if the user can send text messages, contacts, invoices, locations, and venues
  Bool? can_send_basic_messages;

  /// True, if the user can send music files
  Bool? can_send_audios;

  /// True, if the user can send documents
  Bool? can_send_documents;

  /// True, if the user can send audio photos
  Bool? can_send_photos;

  /// True, if the user can send audio videos
  Bool? can_send_videos;

  /// True, if the user can send video notes
  Bool? can_send_video_notes;

  /// True, if the user can send voice notes
  Bool? can_send_voice_notes;

  /// True, if the user can send polls
  Bool? can_send_polls;

  /// True, if the user can send animations, games, stickers, and dice and use inline bots
  Bool? can_send_other_messages;

  /// True, if the user may add a web page preview to their messages
  Bool? can_add_web_page_previews;

  /// True, if the user can change the chat title, photo, and other settings
  Bool? can_change_info;

  /// True, if the user can invite new users to the chat
  Bool? can_invite_users;

  /// True, if the user can pin messages
  Bool? can_pin_messages;

  /// True, if the user can manage topics
  Bool? can_manage_topics;

  ChatPermissions({
    super.extra,
    super.client_id,
    this.can_send_basic_messages,
    this.can_send_audios,
    this.can_send_documents,
    this.can_send_photos,
    this.can_send_videos,
    this.can_send_video_notes,
    this.can_send_voice_notes,
    this.can_send_polls,
    this.can_send_other_messages,
    this.can_add_web_page_previews,
    this.can_change_info,
    this.can_invite_users,
    this.can_pin_messages,
    this.can_manage_topics,
  });

  ChatPermissions.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    can_send_basic_messages = map['can_send_basic_messages'];
    can_send_audios = map['can_send_audios'];
    can_send_documents = map['can_send_documents'];
    can_send_photos = map['can_send_photos'];
    can_send_videos = map['can_send_videos'];
    can_send_video_notes = map['can_send_video_notes'];
    can_send_voice_notes = map['can_send_voice_notes'];
    can_send_polls = map['can_send_polls'];
    can_send_other_messages = map['can_send_other_messages'];
    can_add_web_page_previews = map['can_add_web_page_previews'];
    can_change_info = map['can_change_info'];
    can_invite_users = map['can_invite_users'];
    can_pin_messages = map['can_pin_messages'];
    can_manage_topics = map['can_manage_topics'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'can_send_basic_messages': can_send_basic_messages?.toMap(skipNulls: skipNulls),
      'can_send_audios': can_send_audios?.toMap(skipNulls: skipNulls),
      'can_send_documents': can_send_documents?.toMap(skipNulls: skipNulls),
      'can_send_photos': can_send_photos?.toMap(skipNulls: skipNulls),
      'can_send_videos': can_send_videos?.toMap(skipNulls: skipNulls),
      'can_send_video_notes': can_send_video_notes?.toMap(skipNulls: skipNulls),
      'can_send_voice_notes': can_send_voice_notes?.toMap(skipNulls: skipNulls),
      'can_send_polls': can_send_polls?.toMap(skipNulls: skipNulls),
      'can_send_other_messages': can_send_other_messages?.toMap(skipNulls: skipNulls),
      'can_add_web_page_previews': can_add_web_page_previews?.toMap(skipNulls: skipNulls),
      'can_change_info': can_change_info?.toMap(skipNulls: skipNulls),
      'can_invite_users': can_invite_users?.toMap(skipNulls: skipNulls),
      'can_pin_messages': can_pin_messages?.toMap(skipNulls: skipNulls),
      'can_manage_topics': can_manage_topics?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
