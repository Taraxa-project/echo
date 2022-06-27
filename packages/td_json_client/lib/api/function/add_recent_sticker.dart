import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class AddRecentSticker extends TdFunction {
  String get tdType => 'addRecentSticker';
  String get tdReturnType => 'Stickers';

  string? extra;
  int? client_id;
  Bool? is_attached;
  InputFile? sticker;

  AddRecentSticker({
    this.extra,
    this.client_id,
    this.is_attached,
    this.sticker,
  });

  AddRecentSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_attached = map['is_attached'];
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_attached': is_attached?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
