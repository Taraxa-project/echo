import 'package:td_json_client/src/td_api/td.dart';

/// Describes a Vertical alignment of a table cell content
abstract class PageBlockVerticalAlignment extends TdObject {
  PageBlockVerticalAlignment({super.extra, super.client_id});
}

/// The content must be top-aligned
class PageBlockVerticalAlignmentTop extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentTop';

  PageBlockVerticalAlignmentTop({
    super.extra,
    super.client_id,
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

/// The content must be middle-aligned
class PageBlockVerticalAlignmentMiddle extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentMiddle';

  PageBlockVerticalAlignmentMiddle({
    super.extra,
    super.client_id,
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

/// The content must be bottom-aligned
class PageBlockVerticalAlignmentBottom extends PageBlockVerticalAlignment {
  String get tdType => 'pageBlockVerticalAlignmentBottom';

  PageBlockVerticalAlignmentBottom({
    super.extra,
    super.client_id,
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
