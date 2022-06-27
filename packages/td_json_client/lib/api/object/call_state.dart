import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_protocol.dart';
import 'package:td_json_client/api/object/call_server.dart';
import 'package:td_json_client/api/object/call_discard_reason.dart';
import 'package:td_json_client/api/object/error.dart';

abstract class CallState extends TdObject {}

class CallStatePending extends CallState {
  String get tdType => 'callStatePending';

  string? extra;
  int? client_id;
  Bool? is_created;
  Bool? is_received;

  CallStatePending({
    this.extra,
    this.client_id,
    this.is_created,
    this.is_received,
  });

  CallStatePending.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_created = map['is_created'];
    is_received = map['is_received'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_created': is_created?.toMap(skipNulls: skipNulls),
      'is_received': is_received?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallStateExchangingKeys extends CallState {
  String get tdType => 'callStateExchangingKeys';

  string? extra;
  int? client_id;

  CallStateExchangingKeys({
    this.extra,
    this.client_id,
  });

  CallStateExchangingKeys.fromMap(Map<String, dynamic> map) {
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
class CallStateReady extends CallState {
  String get tdType => 'callStateReady';

  string? extra;
  int? client_id;
  CallProtocol? protocol;
  vector<CallServer>? servers;
  string? config;
  bytes? encryption_key;
  vector<string>? emojis;
  Bool? allow_p2p;

  CallStateReady({
    this.extra,
    this.client_id,
    this.protocol,
    this.servers,
    this.config,
    this.encryption_key,
    this.emojis,
    this.allow_p2p,
  });

  CallStateReady.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    protocol = TdApiMap.fromMap(map['protocol']) as CallProtocol;
    if (map['servers']) {
      servers = [];
      for (var someValue in map['servers']) {
        servers?.add(TdApiMap.fromMap(someValue) as CallServer);
      }
    }
    config = map['config'];
    encryption_key = map['encryption_key'];
    if (map['emojis']) {
      emojis = [];
      for (var someValue in map['emojis']) {
        emojis?.add(someValue);
      }
    }
    allow_p2p = map['allow_p2p'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'protocol': protocol?.toMap(skipNulls: skipNulls),
      'servers': servers?.toMap(skipNulls: skipNulls),
      'config': config?.toMap(skipNulls: skipNulls),
      'encryption_key': encryption_key?.toMap(skipNulls: skipNulls),
      'emojis': emojis?.toMap(skipNulls: skipNulls),
      'allow_p2p': allow_p2p?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallStateHangingUp extends CallState {
  String get tdType => 'callStateHangingUp';

  string? extra;
  int? client_id;

  CallStateHangingUp({
    this.extra,
    this.client_id,
  });

  CallStateHangingUp.fromMap(Map<String, dynamic> map) {
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
class CallStateDiscarded extends CallState {
  String get tdType => 'callStateDiscarded';

  string? extra;
  int? client_id;
  CallDiscardReason? reason;
  Bool? need_rating;
  Bool? need_debug_information;

  CallStateDiscarded({
    this.extra,
    this.client_id,
    this.reason,
    this.need_rating,
    this.need_debug_information,
  });

  CallStateDiscarded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reason = TdApiMap.fromMap(map['reason']) as CallDiscardReason;
    need_rating = map['need_rating'];
    need_debug_information = map['need_debug_information'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
      'need_rating': need_rating?.toMap(skipNulls: skipNulls),
      'need_debug_information': need_debug_information?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class CallStateError extends CallState {
  String get tdType => 'callStateError';

  string? extra;
  int? client_id;
  Error? error;

  CallStateError({
    this.extra,
    this.client_id,
    this.error,
  });

  CallStateError.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    error = TdApiMap.fromMap(map['error']) as Error;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'error': error?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
