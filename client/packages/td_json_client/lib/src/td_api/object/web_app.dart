import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';

/// Describes a Web App. Use getInternalLink with internalLinkTypeWebApp to share the Web App
class WebApp extends TdObject {
  String get tdType => 'webApp';

  /// Web App short name
  string? short_name;

  /// Web App title
  string? title;

  string? description;

  /// Web App photo
  Photo? photo;

  /// Web App animation; may be null
  Animation? animation;

  WebApp({
    super.extra,
    super.client_id,
    this.short_name,
    this.title,
    this.description,
    this.photo,
    this.animation,
  });

  WebApp.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    short_name = map['short_name'];
    title = map['title'];
    description = map['description'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'short_name': short_name?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
