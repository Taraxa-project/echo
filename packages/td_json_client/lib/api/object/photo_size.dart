import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';

class PhotoSize extends TdObject {
  String get tdType => 'photoSize';

  String? extra;
  int? client_id;
  string? type;
  File? photo;
  int32? width;
  int32? height;
  vector<int32>? progressive_sizes;

  PhotoSize({
    this.extra,
    this.client_id,
    this.type,
    this.photo,
    this.width,
    this.height,
    this.progressive_sizes,
  });

  PhotoSize.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    type = map['type'];
    photo = TdApiMap.fromMap(map['photo']) as File;
    width = map['width'];
    height = map['height'];
    if (map['progressive_sizes']) {
      progressive_sizes = [];
      for (var someValue in map['progressive_sizes']) {
        progressive_sizes?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'progressive_sizes': progressive_sizes?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
