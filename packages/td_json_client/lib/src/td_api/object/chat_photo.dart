import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/minithumbnail.dart';
import 'package:td_json_client/src/td_api/object/photo_size.dart';
import 'package:td_json_client/src/td_api/object/animated_chat_photo.dart';

/// Describes a chat or user profile photo
class ChatPhoto extends TdObject {
  String get tdType => 'chatPhoto';

  /// Unique photo identifier
  int64? id;

  /// Point in time (Unix timestamp) when the photo has been added
  int32? added_date;

  /// Photo minithumbnail; may be null
  Minithumbnail? minithumbnail;

  /// Available variants of the photo in JPEG format, in different size
  vector<PhotoSize>? sizes;

  /// A big (640x640) animated variant of the photo in MPEG4 format; may be null
  AnimatedChatPhoto? animation;

  /// A small (160x160) animated variant of the photo in MPEG4 format; may be null even the big animation is available
  AnimatedChatPhoto? small_animation;

  ChatPhoto({
    super.extra,
    super.client_id,
    this.id,
    this.added_date,
    this.minithumbnail,
    this.sizes,
    this.animation,
    this.small_animation,
  });

  ChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    added_date = map['added_date'];
    if (map['minithumbnail'] != null) {
      minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    }
    if (map['sizes'] != null) {
      sizes = [];
      for (var someValue in map['sizes']) {
        if (someValue != null) {
          sizes?.add(TdApiMap.fromMap(someValue) as PhotoSize);
        }
      }
    }
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as AnimatedChatPhoto;
    }
    if (map['small_animation'] != null) {
      small_animation = TdApiMap.fromMap(map['small_animation']) as AnimatedChatPhoto;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'added_date': added_date?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'sizes': sizes?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'small_animation': small_animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
