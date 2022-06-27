import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

abstract class InputChatPhoto extends TdObject {}

class InputChatPhotoPrevious extends InputChatPhoto {
  String get tdType => 'inputChatPhotoPrevious';

  string? extra;
  int? client_id;
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
class InputChatPhotoStatic extends InputChatPhoto {
  String get tdType => 'inputChatPhotoStatic';

  string? extra;
  int? client_id;
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
class InputChatPhotoAnimation extends InputChatPhoto {
  String get tdType => 'inputChatPhotoAnimation';

  string? extra;
  int? client_id;
  InputFile? animation;
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
