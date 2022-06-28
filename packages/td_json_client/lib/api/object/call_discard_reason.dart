import 'package:td_json_client/api/base.dart';

/// Describes the reason why a call was discarded
abstract class CallDiscardReason extends TdObject {}


/// The call wasn't discarded, or the reason is unknown
class CallDiscardReasonEmpty extends CallDiscardReason {
  String get tdType => 'callDiscardReasonEmpty';

  String? extra;
  int? client_id;

  CallDiscardReasonEmpty({
    this.extra,
    this.client_id,
  });

  CallDiscardReasonEmpty.fromMap(Map<String, dynamic> map) {
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

/// The call was ended before the conversation started. It was canceled by the caller or missed by the other party
class CallDiscardReasonMissed extends CallDiscardReason {
  String get tdType => 'callDiscardReasonMissed';

  String? extra;
  int? client_id;

  CallDiscardReasonMissed({
    this.extra,
    this.client_id,
  });

  CallDiscardReasonMissed.fromMap(Map<String, dynamic> map) {
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

/// The call was ended before the conversation started. It was declined by the other party
class CallDiscardReasonDeclined extends CallDiscardReason {
  String get tdType => 'callDiscardReasonDeclined';

  String? extra;
  int? client_id;

  CallDiscardReasonDeclined({
    this.extra,
    this.client_id,
  });

  CallDiscardReasonDeclined.fromMap(Map<String, dynamic> map) {
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

/// The call was ended during the conversation because the users were disconnected
class CallDiscardReasonDisconnected extends CallDiscardReason {
  String get tdType => 'callDiscardReasonDisconnected';

  String? extra;
  int? client_id;

  CallDiscardReasonDisconnected({
    this.extra,
    this.client_id,
  });

  CallDiscardReasonDisconnected.fromMap(Map<String, dynamic> map) {
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

/// The call was ended because one of the parties hung up
class CallDiscardReasonHungUp extends CallDiscardReason {
  String get tdType => 'callDiscardReasonHungUp';

  String? extra;
  int? client_id;

  CallDiscardReasonHungUp({
    this.extra,
    this.client_id,
  });

  CallDiscardReasonHungUp.fromMap(Map<String, dynamic> map) {
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
