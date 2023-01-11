import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes an image in JPEG format
class PhotoSize extends TdObject {
  String get tdType => 'photoSize';


  /// Image type (see https://core.telegram.org/constructor/photoSize)
  string? type;

  /// Information about the image file
  File? photo;

  /// Image width
  int32? width;

  /// Image height
  int32? height;

  /// Sizes of progressive JPEG file prefixes, which can be used to preliminarily show the image; in bytes
  vector<int32>? progressive_sizes;

  PhotoSize({
    super.extra,
    super.client_id,
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
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as File;
    }
    width = map['width'];
    height = map['height'];
    if (map['progressive_sizes'] != null) {
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
