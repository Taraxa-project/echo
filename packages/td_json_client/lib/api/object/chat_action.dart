import 'package:td_json_client/api/base.dart';

/// Describes the different types of activity in a chat
abstract class ChatAction extends TdObject {}


/// The user is typing a message
class ChatActionTyping extends ChatAction {
  String get tdType => 'chatActionTyping';

  String? extra;
  int? client_id;

  ChatActionTyping({
    this.extra,
    this.client_id,
  });

  ChatActionTyping.fromMap(Map<String, dynamic> map) {
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

/// The user is recording a video
class ChatActionRecordingVideo extends ChatAction {
  String get tdType => 'chatActionRecordingVideo';

  String? extra;
  int? client_id;

  ChatActionRecordingVideo({
    this.extra,
    this.client_id,
  });

  ChatActionRecordingVideo.fromMap(Map<String, dynamic> map) {
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

/// The user is uploading a video 
class ChatActionUploadingVideo extends ChatAction {
  String get tdType => 'chatActionUploadingVideo';

  String? extra;
  int? client_id;

  /// Upload progress, as a percentage
  int32? progress;

  ChatActionUploadingVideo({
    this.extra,
    this.client_id,
    this.progress,
  });

  ChatActionUploadingVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    progress = map['progress'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'progress': progress?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is recording a voice note
class ChatActionRecordingVoiceNote extends ChatAction {
  String get tdType => 'chatActionRecordingVoiceNote';

  String? extra;
  int? client_id;

  ChatActionRecordingVoiceNote({
    this.extra,
    this.client_id,
  });

  ChatActionRecordingVoiceNote.fromMap(Map<String, dynamic> map) {
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

/// The user is uploading a voice note 
class ChatActionUploadingVoiceNote extends ChatAction {
  String get tdType => 'chatActionUploadingVoiceNote';

  String? extra;
  int? client_id;

  /// Upload progress, as a percentage
  int32? progress;

  ChatActionUploadingVoiceNote({
    this.extra,
    this.client_id,
    this.progress,
  });

  ChatActionUploadingVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    progress = map['progress'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'progress': progress?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is uploading a photo 
class ChatActionUploadingPhoto extends ChatAction {
  String get tdType => 'chatActionUploadingPhoto';

  String? extra;
  int? client_id;

  /// Upload progress, as a percentage
  int32? progress;

  ChatActionUploadingPhoto({
    this.extra,
    this.client_id,
    this.progress,
  });

  ChatActionUploadingPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    progress = map['progress'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'progress': progress?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is uploading a document 
class ChatActionUploadingDocument extends ChatAction {
  String get tdType => 'chatActionUploadingDocument';

  String? extra;
  int? client_id;

  /// Upload progress, as a percentage
  int32? progress;

  ChatActionUploadingDocument({
    this.extra,
    this.client_id,
    this.progress,
  });

  ChatActionUploadingDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    progress = map['progress'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'progress': progress?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is picking a sticker to send
class ChatActionChoosingSticker extends ChatAction {
  String get tdType => 'chatActionChoosingSticker';

  String? extra;
  int? client_id;

  ChatActionChoosingSticker({
    this.extra,
    this.client_id,
  });

  ChatActionChoosingSticker.fromMap(Map<String, dynamic> map) {
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

/// The user is picking a location or venue to send
class ChatActionChoosingLocation extends ChatAction {
  String get tdType => 'chatActionChoosingLocation';

  String? extra;
  int? client_id;

  ChatActionChoosingLocation({
    this.extra,
    this.client_id,
  });

  ChatActionChoosingLocation.fromMap(Map<String, dynamic> map) {
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

/// The user is picking a contact to send
class ChatActionChoosingContact extends ChatAction {
  String get tdType => 'chatActionChoosingContact';

  String? extra;
  int? client_id;

  ChatActionChoosingContact({
    this.extra,
    this.client_id,
  });

  ChatActionChoosingContact.fromMap(Map<String, dynamic> map) {
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

/// The user has started to play a game
class ChatActionStartPlayingGame extends ChatAction {
  String get tdType => 'chatActionStartPlayingGame';

  String? extra;
  int? client_id;

  ChatActionStartPlayingGame({
    this.extra,
    this.client_id,
  });

  ChatActionStartPlayingGame.fromMap(Map<String, dynamic> map) {
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

/// The user is recording a video note
class ChatActionRecordingVideoNote extends ChatAction {
  String get tdType => 'chatActionRecordingVideoNote';

  String? extra;
  int? client_id;

  ChatActionRecordingVideoNote({
    this.extra,
    this.client_id,
  });

  ChatActionRecordingVideoNote.fromMap(Map<String, dynamic> map) {
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

/// The user is uploading a video note 
class ChatActionUploadingVideoNote extends ChatAction {
  String get tdType => 'chatActionUploadingVideoNote';

  String? extra;
  int? client_id;

  /// Upload progress, as a percentage
  int32? progress;

  ChatActionUploadingVideoNote({
    this.extra,
    this.client_id,
    this.progress,
  });

  ChatActionUploadingVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    progress = map['progress'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'progress': progress?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user is watching animations sent by the other party by clicking on an animated emoji 
class ChatActionWatchingAnimations extends ChatAction {
  String get tdType => 'chatActionWatchingAnimations';

  String? extra;
  int? client_id;

  /// The animated emoji
  string? emoji;

  ChatActionWatchingAnimations({
    this.extra,
    this.client_id,
    this.emoji,
  });

  ChatActionWatchingAnimations.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The user has canceled the previous action
class ChatActionCancel extends ChatAction {
  String get tdType => 'chatActionCancel';

  String? extra;
  int? client_id;

  ChatActionCancel({
    this.extra,
    this.client_id,
  });

  ChatActionCancel.fromMap(Map<String, dynamic> map) {
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
