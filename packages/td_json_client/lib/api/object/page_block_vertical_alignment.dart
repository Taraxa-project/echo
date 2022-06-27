import 'package:td_json_client/api/base.dart';

abstract class PageBlockVerticalAlignment extends TdObject {}

class PageBlockVerticalAlignmentTop extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentTop';

  String? extra;
  int? client_id;

  PageBlockVerticalAlignmentTop({
    this.extra,
    this.client_id,
  });

  PageBlockVerticalAlignmentTop.fromMap(Map<String, dynamic> map) {
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
class PageBlockVerticalAlignmentMiddle extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentMiddle';

  String? extra;
  int? client_id;

  PageBlockVerticalAlignmentMiddle({
    this.extra,
    this.client_id,
  });

  PageBlockVerticalAlignmentMiddle.fromMap(Map<String, dynamic> map) {
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
class PageBlockVerticalAlignmentBottom extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentBottom';

  String? extra;
  int? client_id;

  PageBlockVerticalAlignmentBottom({
    this.extra,
    this.client_id,
  });

  PageBlockVerticalAlignmentBottom.fromMap(Map<String, dynamic> map) {
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
