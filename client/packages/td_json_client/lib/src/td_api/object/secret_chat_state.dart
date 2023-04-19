import 'package:td_json_client/src/td_api/td.dart';

/// Describes the current secret chat state
abstract class SecretChatState extends TdObject {
  SecretChatState({super.extra, super.client_id});
}

/// The secret chat is not yet created; waiting for the other user to get online
class SecretChatStatePending extends SecretChatState {
  String get tdType => 'secretChatStatePending';

  SecretChatStatePending({
    super.extra,
    super.client_id,
  });

  SecretChatStatePending.fromMap(Map<String, dynamic> map) {
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

/// The secret chat is ready to use
class SecretChatStateReady extends SecretChatState {
  String get tdType => 'secretChatStateReady';

  SecretChatStateReady({
    super.extra,
    super.client_id,
  });

  SecretChatStateReady.fromMap(Map<String, dynamic> map) {
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

/// The secret chat is closed
class SecretChatStateClosed extends SecretChatState {
  String get tdType => 'secretChatStateClosed';

  SecretChatStateClosed({
    super.extra,
    super.client_id,
  });

  SecretChatStateClosed.fromMap(Map<String, dynamic> map) {
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
