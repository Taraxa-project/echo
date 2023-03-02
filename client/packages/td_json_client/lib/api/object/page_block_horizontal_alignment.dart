import 'package:td_json_client/api/base.dart';

/// Describes a horizontal alignment of a table cell content
abstract class PageBlockHorizontalAlignment extends TdObject {
  PageBlockHorizontalAlignment({super.extra, super.client_id});
}


/// The content must be left-aligned
class PageBlockHorizontalAlignmentLeft extends PageBlockHorizontalAlignment {
  String get tdType => 'pageBlockHorizontalAlignmentLeft';


  PageBlockHorizontalAlignmentLeft({
    super.extra,
    super.client_id,
  });

  PageBlockHorizontalAlignmentLeft.fromMap(Map<String, dynamic> map) {
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

/// The content must be center-aligned
class PageBlockHorizontalAlignmentCenter extends PageBlockHorizontalAlignment {
  String get tdType => 'pageBlockHorizontalAlignmentCenter';


  PageBlockHorizontalAlignmentCenter({
    super.extra,
    super.client_id,
  });

  PageBlockHorizontalAlignmentCenter.fromMap(Map<String, dynamic> map) {
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

/// The content must be right-aligned
class PageBlockHorizontalAlignmentRight extends PageBlockHorizontalAlignment {
  String get tdType => 'pageBlockHorizontalAlignmentRight';


  PageBlockHorizontalAlignmentRight({
    super.extra,
    super.client_id,
  });

  PageBlockHorizontalAlignmentRight.fromMap(Map<String, dynamic> map) {
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
