import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/story_privacy_settings.dart';

/// Changes privacy settings of a previously sent story
class SetStoryPrivacySettings extends TdFunction {
  String get tdType => 'setStoryPrivacySettings';
  String get tdReturnType => 'Ok';

  /// Identifier of the story
  int32? story_id;

  /// The new privacy settigs for the story
  StoryPrivacySettings? privacy_settings;

  SetStoryPrivacySettings({
    super.extra,
    super.client_id,
    this.story_id,
    this.privacy_settings,
  });

  SetStoryPrivacySettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
    if (map['privacy_settings'] != null) {
      privacy_settings = TdApiMap.fromMap(map['privacy_settings']) as StoryPrivacySettings;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'privacy_settings': privacy_settings?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
