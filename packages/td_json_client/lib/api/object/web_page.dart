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


/// Describes a web page preview
class WebPage extends TdObject {
  String get tdType => 'webPage';

  String? extra;
  int? client_id;

  /// Original URL of the link
  string? url;

  /// URL to display
  string? display_url;

  /// Type of the web page. Can be: article, photo, audio, video, document, profile, app, or something else
  string? type;

  /// Short name of the site (e.g., Google Docs, App Store)
  string? site_name;

  /// Title of the content
  string? title;

  FormattedText? description;

  /// Image representing the content; may be null
  Photo? photo;

  /// URL to show in the embedded preview
  string? embed_url;

  /// MIME type of the embedded preview, (e.g., text/html or video/mp4)
  string? embed_type;

  /// Width of the embedded preview
  int32? embed_width;

  /// Height of the embedded preview
  int32? embed_height;

  /// Duration of the content, in seconds
  int32? duration;

  /// Author of the content
  string? author;

  /// Preview of the content as an animation, if available; may be null
  Animation? animation;

  /// Preview of the content as an audio file, if available; may be null
  Audio? audio;

  /// Preview of the content as a document, if available; may be null
  Document? document;

  /// Preview of the content as a sticker for small WEBP files, if available; may be null
  Sticker? sticker;

  /// Preview of the content as a video, if available; may be null
  Video? video;

  /// Preview of the content as a video note, if available; may be null
  VideoNote? video_note;

  /// Preview of the content as a voice note, if available; may be null
  VoiceNote? voice_note;

  /// Version of instant view, available for the web page (currently, can be 1 or 2), 0 if none
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
