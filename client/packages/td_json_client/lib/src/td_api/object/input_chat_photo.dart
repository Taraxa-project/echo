import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/input_file.dart';
import 'package:td_json_client/src/td_api/object/chat_photo_sticker.dart';

/// Describes a photo to be set as a user profile or chat photo
abstract class InputChatPhoto extends TdObject {
  InputChatPhoto({super.extra, super.client_id});
}

/// A previously used profile photo of the current user
class InputChatPhotoPrevious extends InputChatPhoto {
  String get tdType => 'inputChatPhotoPrevious';

  /// Identifier of the current user's profile photo to reuse
  int64? chat_photo_id;

  InputChatPhotoPrevious({
    super.extra,
    super.client_id,
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

  /// Photo to be set as profile photo. Only inputFileLocal and inputFileGenerated are allowed
  InputFile? photo;

  InputChatPhotoStatic({
    super.extra,
    super.client_id,
    this.photo,
  });

  InputChatPhotoStatic.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputFile;
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

/// An animation in MPEG4 format; must be square, at most 10 seconds long, have width between 160 and 1280 and be at most 2MB in size
class InputChatPhotoAnimation extends InputChatPhoto {
  String get tdType => 'inputChatPhotoAnimation';

  /// Animation to be set as profile photo. Only inputFileLocal and inputFileGenerated are allowed
  InputFile? animation;

  /// Timestamp of the frame, which will be used as static chat photo
  double? main_frame_timestamp;

  InputChatPhotoAnimation({
    super.extra,
    super.client_id,
    this.animation,
    this.main_frame_timestamp,
  });

  InputChatPhotoAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as InputFile;
    }
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

/// A sticker on a custom background
class InputChatPhotoSticker extends InputChatPhoto {
  String get tdType => 'inputChatPhotoSticker';

  /// Information about the sticker
  ChatPhotoSticker? sticker;

  InputChatPhotoSticker({
    super.extra,
    super.client_id,
    this.sticker,
  });

  InputChatPhotoSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as ChatPhotoSticker;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
