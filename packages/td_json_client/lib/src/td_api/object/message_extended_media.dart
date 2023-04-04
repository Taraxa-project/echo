import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/minithumbnail.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/video.dart';

/// Describes a media, which is attached to an invoice
abstract class MessageExtendedMedia extends TdObject {
  MessageExtendedMedia({super.extra, super.client_id});
}

/// The media is hidden until the invoice is paid
class MessageExtendedMediaPreview extends MessageExtendedMedia {
  String get tdType => 'messageExtendedMediaPreview';

  /// Media width; 0 if unknown
  int32? width;

  /// Media height; 0 if unknown
  int32? height;

  /// Media duration; 0 if unknown
  int32? duration;

  /// Media minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Media caption
  FormattedText? caption;

  MessageExtendedMediaPreview({
    super.extra,
    super.client_id,
    this.width,
    this.height,
    this.duration,
    this.minithumbnail,
    this.caption,
  });

  MessageExtendedMediaPreview.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    width = map['width'];
    height = map['height'];
    duration = map['duration'];
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
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
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The media is a photo
class MessageExtendedMediaPhoto extends MessageExtendedMedia {
  String get tdType => 'messageExtendedMediaPhoto';

  /// The photo
  Photo? photo;

  /// Photo caption
  FormattedText? caption;

  MessageExtendedMediaPhoto({
    super.extra,
    super.client_id,
    this.photo,
    this.caption,
  });

  MessageExtendedMediaPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
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
      'photo': photo?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The media is a video
class MessageExtendedMediaVideo extends MessageExtendedMedia {
  String get tdType => 'messageExtendedMediaVideo';

  /// The video
  Video? video;

  /// Photo caption
  FormattedText? caption;

  MessageExtendedMediaVideo({
    super.extra,
    super.client_id,
    this.video,
    this.caption,
  });

  MessageExtendedMediaVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
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
      'video': video?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The media is unuspported
class MessageExtendedMediaUnsupported extends MessageExtendedMedia {
  String get tdType => 'messageExtendedMediaUnsupported';

  /// Media caption
  FormattedText? caption;

  MessageExtendedMediaUnsupported({
    super.extra,
    super.client_id,
    this.caption,
  });

  MessageExtendedMediaUnsupported.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
