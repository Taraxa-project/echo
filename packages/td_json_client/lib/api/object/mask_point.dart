import 'package:td_json_client/api/base.dart';

abstract class MaskPoint extends TdObject {}

class MaskPointForehead extends MaskPoint {
  String get tdType => 'maskPointForehead';

  string? extra;
  int? client_id;

  MaskPointForehead({
    this.extra,
    this.client_id,
  });

  MaskPointForehead.fromMap(Map<String, dynamic> map) {
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
class MaskPointEyes extends MaskPoint {
  String get tdType => 'maskPointEyes';

  string? extra;
  int? client_id;

  MaskPointEyes({
    this.extra,
    this.client_id,
  });

  MaskPointEyes.fromMap(Map<String, dynamic> map) {
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
class MaskPointMouth extends MaskPoint {
  String get tdType => 'maskPointMouth';

  string? extra;
  int? client_id;

  MaskPointMouth({
    this.extra,
    this.client_id,
  });

  MaskPointMouth.fromMap(Map<String, dynamic> map) {
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
class MaskPointChin extends MaskPoint {
  String get tdType => 'maskPointChin';

  string? extra;
  int? client_id;

  MaskPointChin({
    this.extra,
    this.client_id,
  });

  MaskPointChin.fromMap(Map<String, dynamic> map) {
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
