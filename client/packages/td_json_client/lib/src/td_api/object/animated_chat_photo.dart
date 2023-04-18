import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/file.dart';

/// Animated variant of a chat photo in MPEG4 format
class AnimatedChatPhoto extends TdObject {
  String get tdType => 'animatedChatPhoto';

  /// Animation width and height
  int32? length;

  /// Information about the animation file
  File? file;

  /// Timestamp of the frame, used as a static chat photo
  double? main_frame_timestamp;

  AnimatedChatPhoto({
    super.extra,
    super.client_id,
    this.length,
    this.file,
    this.main_frame_timestamp,
  });

  AnimatedChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    length = map['length'];
    if (map['file'] != null) {
      file = TdApiMap.fromMap(map['file']) as File;
    }
    main_frame_timestamp = map['main_frame_timestamp'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
      'file': file?.toMap(skipNulls: skipNulls),
      'main_frame_timestamp': main_frame_timestamp?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
