import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';

class AnimatedChatPhoto extends TdObject {
  String get tdType => 'animatedChatPhoto';

  String? extra;
  int? client_id;
  int32? length;
  File? file;
  double? main_frame_timestamp;

  AnimatedChatPhoto({
    this.extra,
    this.client_id,
    this.length,
    this.file,
    this.main_frame_timestamp,
  });

  AnimatedChatPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    length = map['length'];
    file = TdApiMap.fromMap(map['file']) as File;
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
