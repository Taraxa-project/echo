import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';
import 'package:td_json_client/src/td_api/object/audio.dart';
import 'package:td_json_client/src/td_api/object/document.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';
import 'package:td_json_client/src/td_api/object/video.dart';
import 'package:td_json_client/src/td_api/object/video_note.dart';
import 'package:td_json_client/src/td_api/object/voice_note.dart';

/// Describes a web page preview
class WebPage extends TdObject {
  String get tdType => 'webPage';

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

  /// The identifier of the sender of the previewed story; 0 if none
  int53? story_sender_chat_id;

  /// The identifier of the previewed story; 0 if none
  int32? story_id;

  /// Version of web page instant view (currently, can be 1 or 2); 0 if none
  int32? instant_view_version;

  WebPage({
    super.extra,
    super.client_id,
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
    this.story_sender_chat_id,
    this.story_id,
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
    if (map['description'] != null) {
      description = TdApiMap.fromMap(map['description']) as FormattedText;
    }
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    embed_url = map['embed_url'];
    embed_type = map['embed_type'];
    embed_width = map['embed_width'];
    embed_height = map['embed_height'];
    duration = map['duration'];
    author = map['author'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as Audio;
    }
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as Document;
    }
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
    }
    if (map['video_note'] != null) {
      video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
    }
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    }
    story_sender_chat_id = map['story_sender_chat_id'];
    story_id = map['story_id'];
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
      'story_sender_chat_id': story_sender_chat_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'instant_view_version': instant_view_version?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
