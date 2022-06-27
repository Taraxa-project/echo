import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes an audio file. Audio is usually in MP3 or M4A format 
class Audio extends TdObject {
  String get tdType => 'audio';

  String? extra;
  int? client_id;

  /// Duration of the audio, in seconds; as defined by the sender 
  int32? duration;

  /// Title of the audio; as defined by the sender 
  string? title;

  /// Performer of the audio; as defined by the sender
  string? performer;

  /// Original name of the file; as defined by the sender 
  string? file_name;

  /// The MIME type of the file; as defined by the sender 
  string? mime_type;

  /// The minithumbnail of the album cover; may be null
  Minithumbnail? album_cover_minithumbnail;

  /// The thumbnail of the album cover in JPEG format; as defined by the sender. The full size thumbnail is supposed to be extracted from the downloaded file; may be null 
  Thumbnail? album_cover_thumbnail;

  /// File containing the audio
  File? audio;

  Audio({
    this.extra,
    this.client_id,
    this.duration,
    this.title,
    this.performer,
    this.file_name,
    this.mime_type,
    this.album_cover_minithumbnail,
    this.album_cover_thumbnail,
    this.audio,
  });

  Audio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    title = map['title'];
    performer = map['performer'];
    file_name = map['file_name'];
    mime_type = map['mime_type'];
    album_cover_minithumbnail = TdApiMap.fromMap(map['album_cover_minithumbnail']) as Minithumbnail;
    album_cover_thumbnail = TdApiMap.fromMap(map['album_cover_thumbnail']) as Thumbnail;
    audio = TdApiMap.fromMap(map['audio']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'performer': performer?.toMap(skipNulls: skipNulls),
      'file_name': file_name?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'album_cover_minithumbnail': album_cover_minithumbnail?.toMap(skipNulls: skipNulls),
      'album_cover_thumbnail': album_cover_thumbnail?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
