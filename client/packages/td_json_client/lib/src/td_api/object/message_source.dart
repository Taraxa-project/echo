import 'package:td_json_client/src/td_api/td.dart';

/// Describes source of a message
abstract class MessageSource extends TdObject {
  MessageSource({super.extra, super.client_id});
}

/// The message is from a chat history
class MessageSourceChatHistory extends MessageSource {
  String get tdType => 'messageSourceChatHistory';

  MessageSourceChatHistory({
    super.extra,
    super.client_id,
  });

  MessageSourceChatHistory.fromMap(Map<String, dynamic> map) {
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

/// The message is from a message thread history
class MessageSourceMessageThreadHistory extends MessageSource {
  String get tdType => 'messageSourceMessageThreadHistory';

  MessageSourceMessageThreadHistory({
    super.extra,
    super.client_id,
  });

  MessageSourceMessageThreadHistory.fromMap(Map<String, dynamic> map) {
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

/// The message is from a forum topic history
class MessageSourceForumTopicHistory extends MessageSource {
  String get tdType => 'messageSourceForumTopicHistory';

  MessageSourceForumTopicHistory({
    super.extra,
    super.client_id,
  });

  MessageSourceForumTopicHistory.fromMap(Map<String, dynamic> map) {
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

/// The message is from chat, message thread or forum topic history preview
class MessageSourceHistoryPreview extends MessageSource {
  String get tdType => 'messageSourceHistoryPreview';

  MessageSourceHistoryPreview({
    super.extra,
    super.client_id,
  });

  MessageSourceHistoryPreview.fromMap(Map<String, dynamic> map) {
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

/// The message is from a chat list or a forum topic list
class MessageSourceChatList extends MessageSource {
  String get tdType => 'messageSourceChatList';

  MessageSourceChatList({
    super.extra,
    super.client_id,
  });

  MessageSourceChatList.fromMap(Map<String, dynamic> map) {
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

/// The message is from search results, including file downloads, local file list, outgoing document messages, calendar
class MessageSourceSearch extends MessageSource {
  String get tdType => 'messageSourceSearch';

  MessageSourceSearch({
    super.extra,
    super.client_id,
  });

  MessageSourceSearch.fromMap(Map<String, dynamic> map) {
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

/// The message is from a chat event log
class MessageSourceChatEventLog extends MessageSource {
  String get tdType => 'messageSourceChatEventLog';

  MessageSourceChatEventLog({
    super.extra,
    super.client_id,
  });

  MessageSourceChatEventLog.fromMap(Map<String, dynamic> map) {
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

/// The message is from a notification
class MessageSourceNotification extends MessageSource {
  String get tdType => 'messageSourceNotification';

  MessageSourceNotification({
    super.extra,
    super.client_id,
  });

  MessageSourceNotification.fromMap(Map<String, dynamic> map) {
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

/// The message was screenshotted; the source must be used only if the message content was visible during the screenshot
class MessageSourceScreenshot extends MessageSource {
  String get tdType => 'messageSourceScreenshot';

  MessageSourceScreenshot({
    super.extra,
    super.client_id,
  });

  MessageSourceScreenshot.fromMap(Map<String, dynamic> map) {
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

/// The message is from some other source
class MessageSourceOther extends MessageSource {
  String get tdType => 'messageSourceOther';

  MessageSourceOther({
    super.extra,
    super.client_id,
  });

  MessageSourceOther.fromMap(Map<String, dynamic> map) {
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
