import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/chat_invite_link_info.dart';

/// Describes the type of a URL linking to an internal Telegram entity
abstract class TMeUrlType extends TdObject {
  TMeUrlType({super.extra, super.client_id});
}

/// A URL linking to a user
class TMeUrlTypeUser extends TMeUrlType {
  String get tdType => 'tMeUrlTypeUser';

  /// Identifier of the user
  int53? user_id;

  TMeUrlTypeUser({
    super.extra,
    super.client_id,
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

/// A URL linking to a public supergroup or channel
class TMeUrlTypeSupergroup extends TMeUrlType {
  String get tdType => 'tMeUrlTypeSupergroup';

  /// Identifier of the supergroup or channel
  int53? supergroup_id;

  TMeUrlTypeSupergroup({
    super.extra,
    super.client_id,
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

/// A chat invite link
class TMeUrlTypeChatInvite extends TMeUrlType {
  String get tdType => 'tMeUrlTypeChatInvite';

  /// Information about the chat invite link
  ChatInviteLinkInfo? info;

  TMeUrlTypeChatInvite({
    super.extra,
    super.client_id,
    this.info,
  });

  TMeUrlTypeChatInvite.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['info'] != null) {
      info = TdApiMap.fromMap(map['info']) as ChatInviteLinkInfo;
    }
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

/// A URL linking to a sticker set
class TMeUrlTypeStickerSet extends TMeUrlType {
  String get tdType => 'tMeUrlTypeStickerSet';

  /// Identifier of the sticker set
  int64? sticker_set_id;

  TMeUrlTypeStickerSet({
    super.extra,
    super.client_id,
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
