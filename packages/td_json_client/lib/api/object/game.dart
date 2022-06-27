import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/animation.dart';

class Game extends TdObject {
  String get tdType => 'game';

  string? extra;
  int? client_id;
  int64? id;
  string? short_name;
  string? title;
  FormattedText? text;
  string? description;
  Photo? photo;
  Animation? animation;

  Game({
    this.extra,
    this.client_id,
    this.id,
    this.short_name,
    this.title,
    this.text,
    this.description,
    this.photo,
    this.animation,
  });

  Game.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    short_name = map['short_name'];
    title = map['title'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
    description = map['description'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
    animation = TdApiMap.fromMap(map['animation']) as Animation;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'short_name': short_name?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
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
