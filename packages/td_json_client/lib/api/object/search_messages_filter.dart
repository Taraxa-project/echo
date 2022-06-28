import 'package:td_json_client/api/base.dart';

/// Represents a filter for message search results
abstract class SearchMessagesFilter extends TdObject {}


/// Returns all found messages, no filter is applied
class SearchMessagesFilterEmpty extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterEmpty';

  String? extra;
  int? client_id;

  SearchMessagesFilterEmpty({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterEmpty.fromMap(Map<String, dynamic> map) {
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

/// Returns only animation messages
class SearchMessagesFilterAnimation extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterAnimation';

  String? extra;
  int? client_id;

  SearchMessagesFilterAnimation({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterAnimation.fromMap(Map<String, dynamic> map) {
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

/// Returns only audio messages
class SearchMessagesFilterAudio extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterAudio';

  String? extra;
  int? client_id;

  SearchMessagesFilterAudio({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterAudio.fromMap(Map<String, dynamic> map) {
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

/// Returns only document messages
class SearchMessagesFilterDocument extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterDocument';

  String? extra;
  int? client_id;

  SearchMessagesFilterDocument({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterDocument.fromMap(Map<String, dynamic> map) {
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

/// Returns only photo messages
class SearchMessagesFilterPhoto extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPhoto';

  String? extra;
  int? client_id;

  SearchMessagesFilterPhoto({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterPhoto.fromMap(Map<String, dynamic> map) {
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

/// Returns only video messages
class SearchMessagesFilterVideo extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVideo';

  String? extra;
  int? client_id;

  SearchMessagesFilterVideo({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterVideo.fromMap(Map<String, dynamic> map) {
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

/// Returns only voice note messages
class SearchMessagesFilterVoiceNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVoiceNote';

  String? extra;
  int? client_id;

  SearchMessagesFilterVoiceNote({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterVoiceNote.fromMap(Map<String, dynamic> map) {
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

/// Returns only photo and video messages
class SearchMessagesFilterPhotoAndVideo extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPhotoAndVideo';

  String? extra;
  int? client_id;

  SearchMessagesFilterPhotoAndVideo({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterPhotoAndVideo.fromMap(Map<String, dynamic> map) {
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

/// Returns only messages containing URLs
class SearchMessagesFilterUrl extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUrl';

  String? extra;
  int? client_id;

  SearchMessagesFilterUrl({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterUrl.fromMap(Map<String, dynamic> map) {
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

/// Returns only messages containing chat photos
class SearchMessagesFilterChatPhoto extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterChatPhoto';

  String? extra;
  int? client_id;

  SearchMessagesFilterChatPhoto({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterChatPhoto.fromMap(Map<String, dynamic> map) {
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

/// Returns only video note messages
class SearchMessagesFilterVideoNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVideoNote';

  String? extra;
  int? client_id;

  SearchMessagesFilterVideoNote({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterVideoNote.fromMap(Map<String, dynamic> map) {
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

/// Returns only voice and video note messages
class SearchMessagesFilterVoiceAndVideoNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVoiceAndVideoNote';

  String? extra;
  int? client_id;

  SearchMessagesFilterVoiceAndVideoNote({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterVoiceAndVideoNote.fromMap(Map<String, dynamic> map) {
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

/// Returns only messages with mentions of the current user, or messages that are replies to their messages
class SearchMessagesFilterMention extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterMention';

  String? extra;
  int? client_id;

  SearchMessagesFilterMention({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterMention.fromMap(Map<String, dynamic> map) {
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

/// Returns only messages with unread mentions of the current user, or messages that are replies to their messages. When using this filter the results can't be additionally filtered by a query, a message thread or by the sending user
class SearchMessagesFilterUnreadMention extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUnreadMention';

  String? extra;
  int? client_id;

  SearchMessagesFilterUnreadMention({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterUnreadMention.fromMap(Map<String, dynamic> map) {
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

/// Returns only messages with unread reactions for the current user. When using this filter the results can't be additionally filtered by a query, a message thread or by the sending user
class SearchMessagesFilterUnreadReaction extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUnreadReaction';

  String? extra;
  int? client_id;

  SearchMessagesFilterUnreadReaction({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterUnreadReaction.fromMap(Map<String, dynamic> map) {
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

/// Returns only failed to send messages. This filter can be used only if the message database is used
class SearchMessagesFilterFailedToSend extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterFailedToSend';

  String? extra;
  int? client_id;

  SearchMessagesFilterFailedToSend({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterFailedToSend.fromMap(Map<String, dynamic> map) {
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

/// Returns only pinned messages
class SearchMessagesFilterPinned extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPinned';

  String? extra;
  int? client_id;

  SearchMessagesFilterPinned({
    this.extra,
    this.client_id,
  });

  SearchMessagesFilterPinned.fromMap(Map<String, dynamic> map) {
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
