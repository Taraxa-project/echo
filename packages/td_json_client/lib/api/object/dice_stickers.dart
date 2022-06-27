import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';

abstract class DiceStickers extends TdObject {}

class DiceStickersRegular extends DiceStickers {
  String get tdType => 'diceStickersRegular';

  string? extra;
  int? client_id;
  Sticker? sticker;

  DiceStickersRegular({
    this.extra,
    this.client_id,
    this.sticker,
  });

  DiceStickersRegular.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class DiceStickersSlotMachine extends DiceStickers {
  String get tdType => 'diceStickersSlotMachine';

  string? extra;
  int? client_id;
  Sticker? background;
  Sticker? lever;
  Sticker? left_reel;
  Sticker? center_reel;
  Sticker? right_reel;

  DiceStickersSlotMachine({
    this.extra,
    this.client_id,
    this.background,
    this.lever,
    this.left_reel,
    this.center_reel,
    this.right_reel,
  });

  DiceStickersSlotMachine.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background = TdApiMap.fromMap(map['background']) as Sticker;
    lever = TdApiMap.fromMap(map['lever']) as Sticker;
    left_reel = TdApiMap.fromMap(map['left_reel']) as Sticker;
    center_reel = TdApiMap.fromMap(map['center_reel']) as Sticker;
    right_reel = TdApiMap.fromMap(map['right_reel']) as Sticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background': background?.toMap(skipNulls: skipNulls),
      'lever': lever?.toMap(skipNulls: skipNulls),
      'left_reel': left_reel?.toMap(skipNulls: skipNulls),
      'center_reel': center_reel?.toMap(skipNulls: skipNulls),
      'right_reel': right_reel?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
