import 'package:td_json_client/api/base.dart';

abstract class SearchMessagesFilter extends TdObject {}

class SearchMessagesFilterEmpty extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterEmpty';

  string? extra;
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
class SearchMessagesFilterAnimation extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterAnimation';

  string? extra;
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
class SearchMessagesFilterAudio extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterAudio';

  string? extra;
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
class SearchMessagesFilterDocument extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterDocument';

  string? extra;
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
class SearchMessagesFilterPhoto extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPhoto';

  string? extra;
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
class SearchMessagesFilterVideo extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVideo';

  string? extra;
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
class SearchMessagesFilterVoiceNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVoiceNote';

  string? extra;
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
class SearchMessagesFilterPhotoAndVideo extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPhotoAndVideo';

  string? extra;
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
class SearchMessagesFilterUrl extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUrl';

  string? extra;
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
class SearchMessagesFilterChatPhoto extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterChatPhoto';

  string? extra;
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
class SearchMessagesFilterVideoNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVideoNote';

  string? extra;
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
class SearchMessagesFilterVoiceAndVideoNote extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterVoiceAndVideoNote';

  string? extra;
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
class SearchMessagesFilterMention extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterMention';

  string? extra;
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
class SearchMessagesFilterUnreadMention extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUnreadMention';

  string? extra;
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
class SearchMessagesFilterUnreadReaction extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterUnreadReaction';

  string? extra;
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
class SearchMessagesFilterFailedToSend extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterFailedToSend';

  string? extra;
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
class SearchMessagesFilterPinned extends SearchMessagesFilter {
  String get tdType => 'searchMessagesFilterPinned';

  string? extra;
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
