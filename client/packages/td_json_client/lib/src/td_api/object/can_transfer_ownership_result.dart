import 'package:td_json_client/src/td_api/td.dart';

/// Represents result of checking whether the current session can be used to transfer a chat ownership to another user
abstract class CanTransferOwnershipResult extends TdObject {
  CanTransferOwnershipResult({super.extra, super.client_id});
}

/// The session can be used
class CanTransferOwnershipResultOk extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultOk';

  CanTransferOwnershipResultOk({
    super.extra,
    super.client_id,
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

/// The 2-step verification needs to be enabled first
class CanTransferOwnershipResultPasswordNeeded extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultPasswordNeeded';

  CanTransferOwnershipResultPasswordNeeded({
    super.extra,
    super.client_id,
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

/// The 2-step verification was enabled recently, user needs to wait
class CanTransferOwnershipResultPasswordTooFresh extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultPasswordTooFresh';

  /// Time left before the session can be used to transfer ownership of a chat, in seconds
  int32? retry_after;

  CanTransferOwnershipResultPasswordTooFresh({
    super.extra,
    super.client_id,
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

/// The session was created recently, user needs to wait
class CanTransferOwnershipResultSessionTooFresh extends CanTransferOwnershipResult {
  String get tdType => 'canTransferOwnershipResultSessionTooFresh';

  /// Time left before the session can be used to transfer ownership of a chat, in seconds
  int32? retry_after;

  CanTransferOwnershipResultSessionTooFresh({
    super.extra,
    super.client_id,
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
