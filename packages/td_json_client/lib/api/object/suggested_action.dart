import 'package:td_json_client/api/base.dart';

abstract class SuggestedAction extends TdObject {}

class SuggestedActionEnableArchiveAndMuteNewChats extends SuggestedAction {
  String get tdType => 'suggestedActionEnableArchiveAndMuteNewChats';

  String? extra;
  int? client_id;

  SuggestedActionEnableArchiveAndMuteNewChats({
    this.extra,
    this.client_id,
  });

  SuggestedActionEnableArchiveAndMuteNewChats.fromMap(Map<String, dynamic> map) {
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
class SuggestedActionCheckPassword extends SuggestedAction {
  String get tdType => 'suggestedActionCheckPassword';

  String? extra;
  int? client_id;

  SuggestedActionCheckPassword({
    this.extra,
    this.client_id,
  });

  SuggestedActionCheckPassword.fromMap(Map<String, dynamic> map) {
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
class SuggestedActionCheckPhoneNumber extends SuggestedAction {
  String get tdType => 'suggestedActionCheckPhoneNumber';

  String? extra;
  int? client_id;

  SuggestedActionCheckPhoneNumber({
    this.extra,
    this.client_id,
  });

  SuggestedActionCheckPhoneNumber.fromMap(Map<String, dynamic> map) {
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
class SuggestedActionViewChecksHint extends SuggestedAction {
  String get tdType => 'suggestedActionViewChecksHint';

  String? extra;
  int? client_id;

  SuggestedActionViewChecksHint({
    this.extra,
    this.client_id,
  });

  SuggestedActionViewChecksHint.fromMap(Map<String, dynamic> map) {
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
class SuggestedActionConvertToBroadcastGroup extends SuggestedAction {
  String get tdType => 'suggestedActionConvertToBroadcastGroup';

  String? extra;
  int? client_id;
  int53? supergroup_id;

  SuggestedActionConvertToBroadcastGroup({
    this.extra,
    this.client_id,
    this.supergroup_id,
  });

  SuggestedActionConvertToBroadcastGroup.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class SuggestedActionSetPassword extends SuggestedAction {
  String get tdType => 'suggestedActionSetPassword';

  String? extra;
  int? client_id;
  int32? authorization_delay;

  SuggestedActionSetPassword({
    this.extra,
    this.client_id,
    this.authorization_delay,
  });

  SuggestedActionSetPassword.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    authorization_delay = map['authorization_delay'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'authorization_delay': authorization_delay?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
