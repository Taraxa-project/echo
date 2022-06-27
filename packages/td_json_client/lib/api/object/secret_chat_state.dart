import 'package:td_json_client/api/base.dart';

abstract class SecretChatState extends TdObject {}

class SecretChatStatePending extends SecretChatState {
  String get tdType => 'secretChatStatePending';

  String? extra;
  int? client_id;

  SecretChatStatePending({
    this.extra,
    this.client_id,
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
class SecretChatStateReady extends SecretChatState {
  String get tdType => 'secretChatStateReady';

  String? extra;
  int? client_id;

  SecretChatStateReady({
    this.extra,
    this.client_id,
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
class SecretChatStateClosed extends SecretChatState {
  String get tdType => 'secretChatStateClosed';

  String? extra;
  int? client_id;

  SecretChatStateClosed({
    this.extra,
    this.client_id,
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
