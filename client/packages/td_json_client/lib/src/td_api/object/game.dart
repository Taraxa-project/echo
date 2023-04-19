import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';

/// Describes a game
class Game extends TdObject {
  String get tdType => 'game';

  /// Unique game identifier
  int64? id;

  /// Game short name. To share a game use the URL https://t.me/{bot_username}?game={game_short_name}
  string? short_name;

  /// Game title
  string? title;

  /// Game text, usually containing scoreboards for a game
  FormattedText? text;

  string? description;

  /// Game photo
  Photo? photo;

  /// Game animation; may be null
  Animation? animation;

  Game({
    super.extra,
    super.client_id,
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
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
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
