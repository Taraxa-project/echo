import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/chat_invite_link_info.dart';

abstract class TMeUrlType extends TdObject {}

class TMeUrlTypeUser extends TMeUrlType {
  String get tdType => 'tMeUrlTypeUser';

  string? extra;
  int? client_id;
  int53? user_id;

  TMeUrlTypeUser({
    this.extra,
    this.client_id,
    this.user_id,
  });

  TMeUrlTypeUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class TMeUrlTypeSupergroup extends TMeUrlType {
  String get tdType => 'tMeUrlTypeSupergroup';

  string? extra;
  int? client_id;
  int53? supergroup_id;

  TMeUrlTypeSupergroup({
    this.extra,
    this.client_id,
    this.supergroup_id,
  });

  TMeUrlTypeSupergroup.fromMap(Map<String, dynamic> map) {
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
class TMeUrlTypeChatInvite extends TMeUrlType {
  String get tdType => 'tMeUrlTypeChatInvite';

  string? extra;
  int? client_id;
  ChatInviteLinkInfo? info;

  TMeUrlTypeChatInvite({
    this.extra,
    this.client_id,
    this.info,
  });

  TMeUrlTypeChatInvite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    info = TdApiMap.fromMap(map['info']) as ChatInviteLinkInfo;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'info': info?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class TMeUrlTypeStickerSet extends TMeUrlType {
  String get tdType => 'tMeUrlTypeStickerSet';

  string? extra;
  int? client_id;
  int64? sticker_set_id;

  TMeUrlTypeStickerSet({
    this.extra,
    this.client_id,
    this.sticker_set_id,
  });

  TMeUrlTypeStickerSet.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker_set_id = map['sticker_set_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker_set_id': sticker_set_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
