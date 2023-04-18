import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_photo.dart';

/// Contains a list of chat or user profile photos
class ChatPhotos extends TdObject {
  String get tdType => 'chatPhotos';

  /// Total number of photos
  int32? total_count;

  /// List of photos
  vector<ChatPhoto>? photos;

  ChatPhotos({
    super.extra,
    super.client_id,
    this.total_count,
    this.photos,
  });

  ChatPhotos.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    if (map['photos'] != null) {
      photos = [];
      for (var someValue in map['photos']) {
        if (someValue != null) {
          photos?.add(TdApiMap.fromMap(someValue) as ChatPhoto);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'photos': photos?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
