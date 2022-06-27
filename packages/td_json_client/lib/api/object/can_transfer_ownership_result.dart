import 'package:td_json_client/api/base.dart';

abstract class CanTransferOwnershipResult extends TdObject {}

class CanTransferOwnershipResultOk extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultOk';

  string? extra;
  int? client_id;

  CanTransferOwnershipResultOk({
    this.extra,
    this.client_id,
  });

  CanTransferOwnershipResultOk.fromMap(Map<String, dynamic> map) {
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
class CanTransferOwnershipResultPasswordNeeded extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultPasswordNeeded';

  string? extra;
  int? client_id;

  CanTransferOwnershipResultPasswordNeeded({
    this.extra,
    this.client_id,
  });

  CanTransferOwnershipResultPasswordNeeded.fromMap(Map<String, dynamic> map) {
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
class CanTransferOwnershipResultPasswordTooFresh extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultPasswordTooFresh';

  string? extra;
  int? client_id;
  int32? retry_after;

  CanTransferOwnershipResultPasswordTooFresh({
    this.extra,
    this.client_id,
    this.retry_after,
  });

  CanTransferOwnershipResultPasswordTooFresh.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    retry_after = map['retry_after'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'retry_after': retry_after?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CanTransferOwnershipResultSessionTooFresh extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultSessionTooFresh';

  string? extra;
  int? client_id;
  int32? retry_after;

  CanTransferOwnershipResultSessionTooFresh({
    this.extra,
    this.client_id,
    this.retry_after,
  });

  CanTransferOwnershipResultSessionTooFresh.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    retry_after = map['retry_after'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'retry_after': retry_after?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
