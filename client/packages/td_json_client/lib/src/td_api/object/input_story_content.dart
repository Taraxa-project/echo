import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';

/// The content of a story to send
abstract class InputStoryContent extends TdObject {
  InputStoryContent({super.extra, super.client_id});
}

/// A photo story
class InputStoryContentPhoto extends InputStoryContent {
  String get tdType => 'inputStoryContentPhoto';

  /// Photo to send. The photo must be at most 10 MB in size. The photo size must be 720x1280
  InputFile? photo;

  /// File identifiers of the stickers added to the photo, if applicable
  vector<int32>? added_sticker_file_ids;

  InputStoryContentPhoto({
    super.extra,
    super.client_id,
    this.photo,
    this.added_sticker_file_ids,
  });

  InputStoryContentPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputFile;
    }
    if (map['added_sticker_file_ids'] != null) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'added_sticker_file_ids': added_sticker_file_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video story
class InputStoryContentVideo extends InputStoryContent {
  String get tdType => 'inputStoryContentVideo';

  /// Video to be sent. The video size must be 720x1280. The video must be streamable and stored in MPEG4 format, after encoding with x265 codec and key frames added each second
  InputFile? video;

  /// File identifiers of the stickers added to the video, if applicable
  vector<int32>? added_sticker_file_ids;

  /// Precise duration of the video, in seconds; 0-60
  double? duration;

  /// True, if the video has no sound
  Bool? is_animation;

  InputStoryContentVideo({
    super.extra,
    super.client_id,
    this.video,
    this.added_sticker_file_ids,
    this.duration,
    this.is_animation,
  });

  InputStoryContentVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as InputFile;
    }
    if (map['added_sticker_file_ids'] != null) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    duration = map['duration'];
    is_animation = map['is_animation'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'added_sticker_file_ids': added_sticker_file_ids?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'is_animation': is_animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
