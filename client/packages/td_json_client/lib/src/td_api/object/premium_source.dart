import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/premium_limit_type.dart';
import 'package:td_json_client/src/td_api/object/premium_feature.dart';

/// Describes a source from which the Premium features screen is opened
abstract class PremiumSource extends TdObject {
  PremiumSource({super.extra, super.client_id});
}

/// A limit was exceeded
class PremiumSourceLimitExceeded extends PremiumSource {
  String get tdType => 'premiumSourceLimitExceeded';

  /// Type of the exceeded limit
  PremiumLimitType? limit_type;

  PremiumSourceLimitExceeded({
    super.extra,
    super.client_id,
    this.limit_type,
  });

  PremiumSourceLimitExceeded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['limit_type'] != null) {
      limit_type = TdApiMap.fromMap(map['limit_type']) as PremiumLimitType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'limit_type': limit_type?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A user tried to use a Premium feature
class PremiumSourceFeature extends PremiumSource {
  String get tdType => 'premiumSourceFeature';

  /// The used feature
  PremiumFeature? feature;

  PremiumSourceFeature({
    super.extra,
    super.client_id,
    this.feature,
  });

  PremiumSourceFeature.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['feature'] != null) {
      feature = TdApiMap.fromMap(map['feature']) as PremiumFeature;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'feature': feature?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A user opened an internal link of the type internalLinkTypePremiumFeatures
class PremiumSourceLink extends PremiumSource {
  String get tdType => 'premiumSourceLink';

  /// The referrer from the link
  string? referrer;

  PremiumSourceLink({
    super.extra,
    super.client_id,
    this.referrer,
  });

  PremiumSourceLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    referrer = map['referrer'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'referrer': referrer?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A user opened the Premium features screen from settings
class PremiumSourceSettings extends PremiumSource {
  String get tdType => 'premiumSourceSettings';

  PremiumSourceSettings({
    super.extra,
    super.client_id,
  });

  PremiumSourceSettings.fromMap(Map<String, dynamic> map) {
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
