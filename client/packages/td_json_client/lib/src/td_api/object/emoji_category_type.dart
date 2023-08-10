import 'package:td_json_client/src/td_api/td.dart';

/// Describes type of an emoji category
abstract class EmojiCategoryType extends TdObject {
  EmojiCategoryType({super.extra, super.client_id});
}

/// The category must be used by default
class EmojiCategoryTypeDefault extends EmojiCategoryType {
  String get tdType => 'emojiCategoryTypeDefault';

  EmojiCategoryTypeDefault({
    super.extra,
    super.client_id,
  });

  EmojiCategoryTypeDefault.fromMap(Map<String, dynamic> map) {
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

/// The category must be used for emoji status selection
class EmojiCategoryTypeEmojiStatus extends EmojiCategoryType {
  String get tdType => 'emojiCategoryTypeEmojiStatus';

  EmojiCategoryTypeEmojiStatus({
    super.extra,
    super.client_id,
  });

  EmojiCategoryTypeEmojiStatus.fromMap(Map<String, dynamic> map) {
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

/// The category must be used for chat photo emoji selection
class EmojiCategoryTypeChatPhoto extends EmojiCategoryType {
  String get tdType => 'emojiCategoryTypeChatPhoto';

  EmojiCategoryTypeChatPhoto({
    super.extra,
    super.client_id,
  });

  EmojiCategoryTypeChatPhoto.fromMap(Map<String, dynamic> map) {
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
