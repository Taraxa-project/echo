import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';

class VoiceNote extends TdObject {
  String get tdType => 'voiceNote';

  string? extra;
  int? client_id;
  int32? duration;
  bytes? waveform;
  string? mime_type;
  File? voice;

  VoiceNote({
    this.extra,
    this.client_id,
    this.duration,
    this.waveform,
    this.mime_type,
    this.voice,
  });

  VoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    waveform = map['waveform'];
    mime_type = map['mime_type'];
    voice = TdApiMap.fromMap(map['voice']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'waveform': waveform?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'voice': voice?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
