import 'package:td_json_client/api/base.dart';

abstract class CallDiscardReason extends TdObject {}

class CallDiscardReasonEmpty extends CallDiscardReason {
  String get tdType => 'callDiscardReasonEmpty';

  string? extra;
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
class CallDiscardReasonMissed extends CallDiscardReason {
  String get tdType => 'callDiscardReasonMissed';

  string? extra;
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
class CallDiscardReasonDeclined extends CallDiscardReason {
  String get tdType => 'callDiscardReasonDeclined';

  string? extra;
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
class CallDiscardReasonDisconnected extends CallDiscardReason {
  String get tdType => 'callDiscardReasonDisconnected';

  string? extra;
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
class CallDiscardReasonHungUp extends CallDiscardReason {
  String get tdType => 'callDiscardReasonHungUp';

  string? extra;
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
