import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/photo.dart';


/// Contains information about a related article 
class PageBlockRelatedArticle extends TdObject {
  String get tdType => 'pageBlockRelatedArticle';

  String? extra;
  int? client_id;

  /// Related article URL 
  string? url;

  /// Article title; may be empty 
  string? title;

  string? description;

  /// Article photo; may be null 
  Photo? photo;

  /// Article author; may be empty 
  string? author;

  /// Point in time (Unix timestamp) when the article was published; 0 if unknown
  int32? publish_date;

  PageBlockRelatedArticle({
    this.extra,
    this.client_id,
    this.url,
    this.title,
    this.description,
    this.photo,
    this.author,
    this.publish_date,
  });

  PageBlockRelatedArticle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    title = map['title'];
    description = map['description'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    author = map['author'];
    publish_date = map['publish_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'author': author?.toMap(skipNulls: skipNulls),
      'publish_date': publish_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
