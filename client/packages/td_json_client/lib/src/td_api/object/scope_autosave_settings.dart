import 'package:td_json_client/src/td_api/td.dart';

/// Contains autosave settings for an autosave settings scope
class ScopeAutosaveSettings extends TdObject {
  String get tdType => 'scopeAutosaveSettings';

  /// True, if photo autosave is enabled
  Bool? autosave_photos;

  /// True, if video autosave is enabled
  Bool? autosave_videos;

  /// The maximum size of a video file to be autosaved, in bytes; 512 KB - 4000 MB
  int53? max_video_file_size;

  ScopeAutosaveSettings({
    super.extra,
    super.client_id,
    this.autosave_photos,
    this.autosave_videos,
    this.max_video_file_size,
  });

  ScopeAutosaveSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    autosave_photos = map['autosave_photos'];
    autosave_videos = map['autosave_videos'];
    max_video_file_size = map['max_video_file_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'autosave_photos': autosave_photos?.toMap(skipNulls: skipNulls),
      'autosave_videos': autosave_videos?.toMap(skipNulls: skipNulls),
      'max_video_file_size': max_video_file_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
