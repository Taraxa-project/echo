import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/call_protocol.dart';
import 'package:td_json_client/api/object/call_server.dart';
import 'package:td_json_client/api/object/call_discard_reason.dart';
import 'package:td_json_client/api/object/error.dart';

/// Describes the current call state
abstract class CallState extends TdObject {}


/// The call is pending, waiting to be accepted by a user 
class CallStatePending extends CallState {
  String get tdType => 'callStatePending';

  String? extra;
  int? client_id;

  /// True, if the call has already been created by the server 
  Bool? is_created;

  /// True, if the call has already been received by the other party
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

/// The call has been answered and encryption keys are being exchanged
class CallStateExchangingKeys extends CallState {
  String get tdType => 'callStateExchangingKeys';

  String? extra;
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

/// The call is ready to use 
class CallStateReady extends CallState {
  String get tdType => 'callStateReady';

  String? extra;
  int? client_id;

  /// Call protocols supported by the peer 
  CallProtocol? protocol;

  /// List of available call servers 
  vector<CallServer>? servers;

  /// A JSON-encoded call config 
  string? config;

  /// Call encryption key 
  bytes? encryption_key;

  /// Encryption key emojis fingerprint 
  vector<string>? emojis;

  /// True, if peer-to-peer connection is allowed by users privacy settings
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

/// The call is hanging up after discardCall has been called
class CallStateHangingUp extends CallState {
  String get tdType => 'callStateHangingUp';

  String? extra;
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

/// The call has ended successfully 
class CallStateDiscarded extends CallState {
  String get tdType => 'callStateDiscarded';

  String? extra;
  int? client_id;

  /// The reason, why the call has ended 
  CallDiscardReason? reason;

  /// True, if the call rating must be sent to the server 
  Bool? need_rating;

  /// True, if the call debug information must be sent to the server 
  Bool? need_debug_information;

  /// True, if the call log must be sent to the server
  Bool? need_log;

  CallStateDiscarded({
    this.extra,
    this.client_id,
    this.reason,
    this.need_rating,
    this.need_debug_information,
    this.need_log,
  });

  CallStateDiscarded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    reason = TdApiMap.fromMap(map['reason']) as CallDiscardReason;
    need_rating = map['need_rating'];
    need_debug_information = map['need_debug_information'];
    need_log = map['need_log'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'reason': reason?.toMap(skipNulls: skipNulls),
      'need_rating': need_rating?.toMap(skipNulls: skipNulls),
      'need_debug_information': need_debug_information?.toMap(skipNulls: skipNulls),
      'need_log': need_log?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The call has ended with an error 
class CallStateError extends CallState {
  String get tdType => 'callStateError';

  String? extra;
  int? client_id;

  /// Error. An error with the code 4005000 will be returned if an outgoing call is missed because of an expired timeout
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
