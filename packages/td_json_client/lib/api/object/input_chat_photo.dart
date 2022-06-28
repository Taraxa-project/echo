import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

/// Describes a photo to be set as a user profile or chat photo
abstract class InputChatPhoto extends TdObject {}


/// A previously used profile photo of the current user 
class InputChatPhotoPrevious extends InputChatPhoto {
  String get tdType => 'inputChatPhotoPrevious';

  String? extra;
  int? client_id;

  /// Identifier of the current user's profile photo to reuse
  int64? chat_photo_id;

  InputChatPhotoPrevious({
    this.extra,
    this.client_id,
    this.chat_photo_id,
  });

  InputChatPhotoPrevious.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    chat_photo_id = map['chat_photo_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'chat_photo_id': chat_photo_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A static photo in JPEG format 
class InputChatPhotoStatic extends InputChatPhoto {
  String get tdType => 'inputChatPhotoStatic';

  String? extra;
  int? client_id;

  /// Photo to be set as profile photo. Only inputFileLocal and inputFileGenerated are allowed
  InputFile? photo;

  InputChatPhotoStatic({
    this.extra,
    this.client_id,
    this.photo,
  });

  InputChatPhotoStatic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as InputFile;
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

/// An animation in MPEG4 format; must be square, at most 10 seconds long, have width between 160 and 800 and be at most 2MB in size
class InputChatPhotoAnimation extends InputChatPhoto {
  String get tdType => 'inputChatPhotoAnimation';

  String? extra;
  int? client_id;

  /// Animation to be set as profile photo. Only inputFileLocal and inputFileGenerated are allowed
  InputFile? animation;

  /// Timestamp of the frame, which will be used as static chat photo
  double? main_frame_timestamp;

  InputChatPhotoAnimation({
    this.extra,
    this.client_id,
    this.animation,
    this.main_frame_timestamp,
  });

  InputChatPhotoAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    animation = TdApiMap.fromMap(map['animation']) as InputFile;
    main_frame_timestamp = map['main_frame_timestamp'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'main_frame_timestamp': main_frame_timestamp?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
