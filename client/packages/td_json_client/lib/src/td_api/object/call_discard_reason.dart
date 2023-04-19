import 'package:td_json_client/src/td_api/td.dart';

/// Describes the reason why a call was discarded
abstract class CallDiscardReason extends TdObject {
  CallDiscardReason({super.extra, super.client_id});
}

/// The call wasn't discarded, or the reason is unknown
class CallDiscardReasonEmpty extends CallDiscardReason {
  String get tdType => 'callDiscardReasonEmpty';

  CallDiscardReasonEmpty({
    super.extra,
    super.client_id,
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

  CallDiscardReasonMissed({
    super.extra,
    super.client_id,
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

  CallDiscardReasonDeclined({
    super.extra,
    super.client_id,
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

  CallDiscardReasonDisconnected({
    super.extra,
    super.client_id,
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

  CallDiscardReasonHungUp({
    super.extra,
    super.client_id,
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
