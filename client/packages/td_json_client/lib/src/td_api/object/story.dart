import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story_interaction_info.dart';
import 'package:td_json_client/src/td_api/object/story_privacy_settings.dart';
import 'package:td_json_client/src/td_api/object/story_content.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';

/// Represents a story
class Story extends TdObject {
  String get tdType => 'story';

  /// Unique story identifier among stories of the given sender
  int32? id;

  /// Identifier of the chat that posted the story
  int53? sender_chat_id;

  /// Point in time (Unix timestamp) when the story was published
  int32? date;

  /// True, if the story is being edited by the current user
  Bool? is_being_edited;

  /// True, if the story was edited
  Bool? is_edited;

  /// True, if the story is saved in the sender's profile and will be available there after expiration
  Bool? is_pinned;

  /// True, if the story is visible only for the current user
  Bool? is_visible_only_for_self;

  /// True, if the story can be forwarded as a message. Otherwise, screenshots and saving of the story content must be also forbidden
  Bool? can_be_forwarded;

  /// True, if the story can be replied in the chat with the story sender
  Bool? can_be_replied;

  /// True, if users viewed the story can be received through getStoryViewers
  Bool? can_get_viewers;

  /// True, if users viewed the story can't be received, because the story has expired more than getOption("story_viewers_expiration_delay") seconds ago
  Bool? has_expired_viewers;

  /// Information about interactions with the story; may be null if the story isn't owned or there were no interactions
  StoryInteractionInfo? interaction_info;

  /// Privacy rules affecting story visibility; may be approximate for non-owned stories
  StoryPrivacySettings? privacy_settings;

  /// Content of the story
  StoryContent? content;

  /// Caption of the story
  FormattedText? caption;

  Story({
    super.extra,
    super.client_id,
    this.id,
    this.sender_chat_id,
    this.date,
    this.is_being_edited,
    this.is_edited,
    this.is_pinned,
    this.is_visible_only_for_self,
    this.can_be_forwarded,
    this.can_be_replied,
    this.can_get_viewers,
    this.has_expired_viewers,
    this.interaction_info,
    this.privacy_settings,
    this.content,
    this.caption,
  });

  Story.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sender_chat_id = map['sender_chat_id'];
    date = map['date'];
    is_being_edited = map['is_being_edited'];
    is_edited = map['is_edited'];
    is_pinned = map['is_pinned'];
    is_visible_only_for_self = map['is_visible_only_for_self'];
    can_be_forwarded = map['can_be_forwarded'];
    can_be_replied = map['can_be_replied'];
    can_get_viewers = map['can_get_viewers'];
    has_expired_viewers = map['has_expired_viewers'];
    if (map['interaction_info'] != null) {
      interaction_info = TdApiMap.fromMap(map['interaction_info']) as StoryInteractionInfo;
    }
    if (map['privacy_settings'] != null) {
      privacy_settings = TdApiMap.fromMap(map['privacy_settings']) as StoryPrivacySettings;
    }
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as StoryContent;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sender_chat_id': sender_chat_id?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'is_being_edited': is_being_edited?.toMap(skipNulls: skipNulls),
      'is_edited': is_edited?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
      'is_visible_only_for_self': is_visible_only_for_self?.toMap(skipNulls: skipNulls),
      'can_be_forwarded': can_be_forwarded?.toMap(skipNulls: skipNulls),
      'can_be_replied': can_be_replied?.toMap(skipNulls: skipNulls),
      'can_get_viewers': can_get_viewers?.toMap(skipNulls: skipNulls),
      'has_expired_viewers': has_expired_viewers?.toMap(skipNulls: skipNulls),
      'interaction_info': interaction_info?.toMap(skipNulls: skipNulls),
      'privacy_settings': privacy_settings?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
