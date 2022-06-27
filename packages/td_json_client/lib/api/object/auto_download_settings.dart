import 'package:td_json_client/api/base.dart';

class AutoDownloadSettings extends TdObject {
  String get tdType => 'autoDownloadSettings';

  string? extra;
  int? client_id;
  Bool? is_auto_download_enabled;
  int32? max_photo_file_size;
  int32? max_video_file_size;
  int32? max_other_file_size;
  int32? video_upload_bitrate;
  Bool? preload_large_videos;
  Bool? preload_next_audio;
  Bool? use_less_data_for_calls;

  AutoDownloadSettings({
    this.extra,
    this.client_id,
    this.is_auto_download_enabled,
    this.max_photo_file_size,
    this.max_video_file_size,
    this.max_other_file_size,
    this.video_upload_bitrate,
    this.preload_large_videos,
    this.preload_next_audio,
    this.use_less_data_for_calls,
  });

  AutoDownloadSettings.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_auto_download_enabled = map['is_auto_download_enabled'];
    max_photo_file_size = map['max_photo_file_size'];
    max_video_file_size = map['max_video_file_size'];
    max_other_file_size = map['max_other_file_size'];
    video_upload_bitrate = map['video_upload_bitrate'];
    preload_large_videos = map['preload_large_videos'];
    preload_next_audio = map['preload_next_audio'];
    use_less_data_for_calls = map['use_less_data_for_calls'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_auto_download_enabled': is_auto_download_enabled?.toMap(skipNulls: skipNulls),
      'max_photo_file_size': max_photo_file_size?.toMap(skipNulls: skipNulls),
      'max_video_file_size': max_video_file_size?.toMap(skipNulls: skipNulls),
      'max_other_file_size': max_other_file_size?.toMap(skipNulls: skipNulls),
      'video_upload_bitrate': video_upload_bitrate?.toMap(skipNulls: skipNulls),
      'preload_large_videos': preload_large_videos?.toMap(skipNulls: skipNulls),
      'preload_next_audio': preload_next_audio?.toMap(skipNulls: skipNulls),
      'use_less_data_for_calls': use_less_data_for_calls?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
