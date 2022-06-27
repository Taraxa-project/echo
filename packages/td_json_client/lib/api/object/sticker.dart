import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker_type.dart';
import 'package:td_json_client/api/object/closed_vector_path.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';

class Sticker extends TdObject {
  String get tdType => 'sticker';

  string? extra;
  int? client_id;
  int64? set_id;
  int32? width;
  int32? height;
  string? emoji;
  StickerType? type;
  vector<ClosedVectorPath>? outline;
  Thumbnail? thumbnail;
  File? sticker;

  Sticker({
    this.extra,
    this.client_id,
    this.set_id,
    this.width,
    this.height,
    this.emoji,
    this.type,
    this.outline,
    this.thumbnail,
    this.sticker,
  });

  Sticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    set_id = map['set_id'];
    width = map['width'];
    height = map['height'];
    emoji = map['emoji'];
    type = TdApiMap.fromMap(map['type']) as StickerType;
    if (map['outline']) {
      outline = [];
      for (var someValue in map['outline']) {
        outline?.add(TdApiMap.fromMap(someValue) as ClosedVectorPath);
      }
    }
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    sticker = TdApiMap.fromMap(map['sticker']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'set_id': set_id?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'outline': outline?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
