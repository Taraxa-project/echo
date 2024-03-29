import 'package:td_json_client/src/td_api/td.dart';

/// Represents result of checking whether a name can be used for a new sticker set
abstract class CheckStickerSetNameResult extends TdObject {
  CheckStickerSetNameResult({super.extra, super.client_id});
}

/// The name can be set
class CheckStickerSetNameResultOk extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultOk';

  CheckStickerSetNameResultOk({
    super.extra,
    super.client_id,
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

/// The name is invalid
class CheckStickerSetNameResultNameInvalid extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultNameInvalid';

  CheckStickerSetNameResultNameInvalid({
    super.extra,
    super.client_id,
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

/// The name is occupied
class CheckStickerSetNameResultNameOccupied extends CheckStickerSetNameResult {
  String get tdType => 'checkStickerSetNameResultNameOccupied';

  CheckStickerSetNameResultNameOccupied({
    super.extra,
    super.client_id,
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
