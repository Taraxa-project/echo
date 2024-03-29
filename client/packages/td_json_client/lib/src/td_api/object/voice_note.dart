import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/speech_recognition_result.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Describes a voice note. The voice note must be encoded with the Opus codec, and stored inside an OGG container. Voice notes can have only a single audio channel
class VoiceNote extends TdObject {
  String get tdType => 'voiceNote';

  /// Duration of the voice note, in seconds; as defined by the sender
  int32? duration;

  /// A waveform representation of the voice note in 5-bit format
  bytes? waveform;

  /// MIME type of the file; as defined by the sender
  string? mime_type;

  /// Result of speech recognition in the voice note; may be null
  SpeechRecognitionResult? speech_recognition_result;

  /// File containing the voice note
  File? voice;

  VoiceNote({
    super.extra,
    super.client_id,
    this.duration,
    this.waveform,
    this.mime_type,
    this.speech_recognition_result,
    this.voice,
  });

  VoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
    waveform = map['waveform'];
    mime_type = map['mime_type'];
    if (map['speech_recognition_result'] != null) {
      speech_recognition_result = TdApiMap.fromMap(map['speech_recognition_result']) as SpeechRecognitionResult;
    }
    if (map['voice'] != null) {
      voice = TdApiMap.fromMap(map['voice']) as File;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'waveform': waveform?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'speech_recognition_result': speech_recognition_result?.toMap(skipNulls: skipNulls),
      'voice': voice?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
