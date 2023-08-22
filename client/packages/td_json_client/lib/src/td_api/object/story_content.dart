import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/story_video.dart';

/// Contains the content of a story
abstract class StoryContent extends TdObject {
  StoryContent({super.extra, super.client_id});
}

/// A photo story
class StoryContentPhoto extends StoryContent {
  String get tdType => 'storyContentPhoto';

  /// The photo
  Photo? photo;

  StoryContentPhoto({
    super.extra,
    super.client_id,
    this.photo,
  });

  StoryContentPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video story
class StoryContentVideo extends StoryContent {
  String get tdType => 'storyContentVideo';

  /// The video in MPEG4 format
  StoryVideo? video;

  /// Alternative version of the video in MPEG4 format, encoded by x264 codec; may be null
  StoryVideo? alternative_video;

  StoryContentVideo({
    super.extra,
    super.client_id,
    this.video,
    this.alternative_video,
  });

  StoryContentVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as StoryVideo;
    }
    if (map['alternative_video'] != null) {
      alternative_video = TdApiMap.fromMap(map['alternative_video']) as StoryVideo;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'alternative_video': alternative_video?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A story content that is not supported in the current TDLib version
class StoryContentUnsupported extends StoryContent {
  String get tdType => 'storyContentUnsupported';

  StoryContentUnsupported({
    super.extra,
    super.client_id,
  });

  StoryContentUnsupported.fromMap(Map<String, dynamic> map) {
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
