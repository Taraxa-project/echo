import 'package:td_json_client/src/td_api/td.dart';

/// Represents a filter for message search results
abstract class SearchMessagesFilter extends TdObject {
  SearchMessagesFilter({super.extra, super.client_id});
}

/// Returns all found messages, no filter is applied
class SearchMessagesFilterEmpty extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterEmpty';

  SearchMessagesFilterEmpty({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterAnimation({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterAudio({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterDocument({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterPhoto({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterVideo({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterVoiceNote({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterPhotoAndVideo({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterUrl({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterChatPhoto({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterVideoNote({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterVoiceAndVideoNote({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterMention({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterUnreadMention({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterUnreadReaction({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterFailedToSend({
    super.extra,
    super.client_id,
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

  SearchMessagesFilterPinned({
    super.extra,
    super.client_id,
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
