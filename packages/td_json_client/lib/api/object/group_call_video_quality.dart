import 'package:td_json_client/api/base.dart';

/// Describes the quality of a group call video
abstract class GroupCallVideoQuality extends TdObject {}


/// The worst available video quality
class GroupCallVideoQualityThumbnail extends GroupCallVideoQuality {
  String get tdType => 'groupCallVideoQualityThumbnail';

  String? extra;
  int? client_id;

  GroupCallVideoQualityThumbnail({
    this.extra,
    this.client_id,
  });

  GroupCallVideoQualityThumbnail.fromMap(Map<String, dynamic> map) {
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

/// The medium video quality
class GroupCallVideoQualityMedium extends GroupCallVideoQuality {
  String get tdType => 'groupCallVideoQualityMedium';

  String? extra;
  int? client_id;

  GroupCallVideoQualityMedium({
    this.extra,
    this.client_id,
  });

  GroupCallVideoQualityMedium.fromMap(Map<String, dynamic> map) {
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

/// The best available video quality
class GroupCallVideoQualityFull extends GroupCallVideoQuality {
  String get tdType => 'groupCallVideoQualityFull';

  String? extra;
  int? client_id;

  GroupCallVideoQualityFull({
    this.extra,
    this.client_id,
  });

  GroupCallVideoQualityFull.fromMap(Map<String, dynamic> map) {
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
