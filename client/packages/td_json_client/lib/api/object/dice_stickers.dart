import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/sticker.dart';

/// Contains animated stickers which must be used for dice animation rendering
abstract class DiceStickers extends TdObject {
  DiceStickers({super.extra, super.client_id});
}


/// A regular animated sticker 
class DiceStickersRegular extends DiceStickers {
  String get tdType => 'diceStickersRegular';


  /// The animated sticker with the dice animation
  Sticker? sticker;

  DiceStickersRegular({
    super.extra,
    super.client_id,
    this.sticker,
  });

  DiceStickersRegular.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
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

/// Animated stickers to be combined into a slot machine
class DiceStickersSlotMachine extends DiceStickers {
  String get tdType => 'diceStickersSlotMachine';


  /// The animated sticker with the slot machine background. The background animation must start playing after all reel animations finish
  Sticker? background;

  /// The animated sticker with the lever animation. The lever animation must play once in the initial dice state
  Sticker? lever;

  /// The animated sticker with the left reel
  Sticker? left_reel;

  /// The animated sticker with the center reel
  Sticker? center_reel;

  /// The animated sticker with the right reel
  Sticker? right_reel;

  DiceStickersSlotMachine({
    super.extra,
    super.client_id,
    this.background,
    this.lever,
    this.left_reel,
    this.center_reel,
    this.right_reel,
  });

  DiceStickersSlotMachine.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['background'] != null) {
      background = TdApiMap.fromMap(map['background']) as Sticker;
    }
    if (map['lever'] != null) {
      lever = TdApiMap.fromMap(map['lever']) as Sticker;
    }
    if (map['left_reel'] != null) {
      left_reel = TdApiMap.fromMap(map['left_reel']) as Sticker;
    }
    if (map['center_reel'] != null) {
      center_reel = TdApiMap.fromMap(map['center_reel']) as Sticker;
    }
    if (map['right_reel'] != null) {
      right_reel = TdApiMap.fromMap(map['right_reel']) as Sticker;
    }
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
