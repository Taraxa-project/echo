import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_story_content.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/story_privacy_settings.dart';

/// Sends a new story. Returns a temporary story with identifier 0
class SendStory extends TdFunction {
  String get tdType => 'sendStory';
  String get tdReturnType => 'Story';

  /// Content of the story
  InputStoryContent? content;

  /// Story caption; pass null to use an empty caption; 0-getOption("story_caption_length_max") characters
  FormattedText? caption;

  /// The privacy settings for the story
  StoryPrivacySettings? privacy_settings;

  /// Period after which the story is moved to archive, in seconds; must be one of 6 * 3600, 12 * 3600, 86400, 2 * 86400, 3 * 86400, or 7 * 86400 for Telegram Premium users, and 86400 otherwise
  int32? active_period;

  /// Pass true to keep the story accessible after expiration
  Bool? is_pinned;

  /// Pass true if the content of the story must be protected from forwarding and screenshotting
  Bool? protect_content;

  SendStory({
    super.extra,
    super.client_id,
    this.content,
    this.caption,
    this.privacy_settings,
    this.active_period,
    this.is_pinned,
    this.protect_content,
  });

  SendStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['content'] != null) {
      content = TdApiMap.fromMap(map['content']) as InputStoryContent;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
    if (map['privacy_settings'] != null) {
      privacy_settings = TdApiMap.fromMap(map['privacy_settings']) as StoryPrivacySettings;
    }
    active_period = map['active_period'];
    is_pinned = map['is_pinned'];
    protect_content = map['protect_content'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'content': content?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'privacy_settings': privacy_settings?.toMap(skipNulls: skipNulls),
      'active_period': active_period?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
      'protect_content': protect_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
