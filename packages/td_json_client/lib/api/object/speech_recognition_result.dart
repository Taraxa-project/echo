import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/error.dart';

/// Describes result of speech recognition in a voice note
abstract class SpeechRecognitionResult extends TdObject {
  SpeechRecognitionResult({super.extra, super.client_id});
}


/// The speech recognition is ongoing 
class SpeechRecognitionResultPending extends SpeechRecognitionResult {
  String get tdType => 'speechRecognitionResultPending';


  /// Partially recognized text
  string? partial_text;

  SpeechRecognitionResultPending({
    super.extra,
    super.client_id,
    this.partial_text,
  });

  SpeechRecognitionResultPending.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    partial_text = map['partial_text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'partial_text': partial_text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The speech recognition successfully finished 
class SpeechRecognitionResultText extends SpeechRecognitionResult {
  String get tdType => 'speechRecognitionResultText';


  /// Recognized text
  string? text;

  SpeechRecognitionResultText({
    super.extra,
    super.client_id,
    this.text,
  });

  SpeechRecognitionResultText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The speech recognition failed 
class SpeechRecognitionResultError extends SpeechRecognitionResult {
  String get tdType => 'speechRecognitionResultError';


  /// Received error
  Error? error;

  SpeechRecognitionResultError({
    super.extra,
    super.client_id,
    this.error,
  });

  SpeechRecognitionResultError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['error'] != null) {
      error = TdApiMap.fromMap(map['error']) as Error;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'error': error?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
