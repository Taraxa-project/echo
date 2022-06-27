import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/video_note.dart';
import 'package:td_json_client/api/object/voice_note.dart';

class WebPage extends TdObject {
  String get tdType => 'webPage';

  string? extra;
  int? client_id;
  string? url;
  string? display_url;
  string? type;
  string? site_name;
  string? title;
  FormattedText? description;
  Photo? photo;
  string? embed_url;
  string? embed_type;
  int32? embed_width;
  int32? embed_height;
  int32? duration;
  string? author;
  Animation? animation;
  Audio? audio;
  Document? document;
  Sticker? sticker;
  Video? video;
  VideoNote? video_note;
  VoiceNote? voice_note;
  int32? instant_view_version;

  WebPage({
    this.extra,
    this.client_id,
    this.url,
    this.display_url,
    this.type,
    this.site_name,
    this.title,
    this.description,
    this.photo,
    this.embed_url,
    this.embed_type,
    this.embed_width,
    this.embed_height,
    this.duration,
    this.author,
    this.animation,
    this.audio,
    this.document,
    this.sticker,
    this.video,
    this.video_note,
    this.voice_note,
    this.instant_view_version,
  });

  WebPage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    display_url = map['display_url'];
    type = map['type'];
    site_name = map['site_name'];
    title = map['title'];
    description = TdApiMap.fromMap(map['description']) as FormattedText;
    photo = TdApiMap.fromMap(map['photo']) as Photo;
    embed_url = map['embed_url'];
    embed_type = map['embed_type'];
    embed_width = map['embed_width'];
    embed_height = map['embed_height'];
    duration = map['duration'];
    author = map['author'];
    animation = TdApiMap.fromMap(map['animation']) as Animation;
    audio = TdApiMap.fromMap(map['audio']) as Audio;
    document = TdApiMap.fromMap(map['document']) as Document;
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    video = TdApiMap.fromMap(map['video']) as Video;
    video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
    voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    instant_view_version = map['instant_view_version'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'display_url': display_url?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'site_name': site_name?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'embed_url': embed_url?.toMap(skipNulls: skipNulls),
      'embed_type': embed_type?.toMap(skipNulls: skipNulls),
      'embed_width': embed_width?.toMap(skipNulls: skipNulls),
      'embed_height': embed_height?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'author': author?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'video_note': video_note?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'instant_view_version': instant_view_version?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
