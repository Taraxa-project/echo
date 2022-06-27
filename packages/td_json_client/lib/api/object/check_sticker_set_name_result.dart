import 'package:td_json_client/api/base.dart';

abstract class CheckStickerSetNameResult extends TdObject {}

class CheckStickerSetNameResultOk extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultOk';

  string? extra;
  int? client_id;

  CheckStickerSetNameResultOk({
    this.extra,
    this.client_id,
  });

  CheckStickerSetNameResultOk.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CheckStickerSetNameResultNameInvalid extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultNameInvalid';

  string? extra;
  int? client_id;

  CheckStickerSetNameResultNameInvalid({
    this.extra,
    this.client_id,
  });

  CheckStickerSetNameResultNameInvalid.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CheckStickerSetNameResultNameOccupied extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultNameOccupied';

  string? extra;
  int? client_id;

  CheckStickerSetNameResultNameOccupied({
    this.extra,
    this.client_id,
  });

  CheckStickerSetNameResultNameOccupied.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
