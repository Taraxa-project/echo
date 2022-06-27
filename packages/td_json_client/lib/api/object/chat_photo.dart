import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/photo_size.dart';
import 'package:td_json_client/api/object/animated_chat_photo.dart';

class ChatPhoto extends TdObject {
  String get tdType => 'chatPhoto';

  String? extra;
  int? client_id;
  int64? id;
  int32? added_date;
  Minithumbnail? minithumbnail;
  vector<PhotoSize>? sizes;
  AnimatedChatPhoto? animation;

  ChatPhoto({
    this.extra,
    this.client_id,
    this.id,
    this.added_date,
    this.minithumbnail,
    this.sizes,
    this.animation,
  });

  ChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    added_date = map['added_date'];
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    if (map['sizes']) {
      sizes = [];
      for (var someValue in map['sizes']) {
        sizes?.add(TdApiMap.fromMap(someValue) as PhotoSize);
      }
    }
    animation = TdApiMap.fromMap(map['animation']) as AnimatedChatPhoto;
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
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
