import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/animation.dart';
import 'package:td_json_client/src/td_api/object/audio.dart';
import 'package:td_json_client/src/td_api/object/document.dart';
import 'package:td_json_client/src/td_api/object/photo.dart';
import 'package:td_json_client/src/td_api/object/sticker.dart';
import 'package:td_json_client/src/td_api/object/video.dart';
import 'package:td_json_client/src/td_api/object/video_note.dart';
import 'package:td_json_client/src/td_api/object/voice_note.dart';

/// Contains content of a push message notification
abstract class PushMessageContent extends TdObject {
  PushMessageContent({super.extra, super.client_id});
}

/// A general message with hidden content
class PushMessageContentHidden extends PushMessageContent {
  String get tdType => 'pushMessageContentHidden';

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentHidden({
    super.extra,
    super.client_id,
    this.is_pinned,
  });

  PushMessageContentHidden.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An animation message (GIF-style).
class PushMessageContentAnimation extends PushMessageContent {
  String get tdType => 'pushMessageContentAnimation';

  /// Message content; may be null
  Animation? animation;

  /// Animation caption
  string? caption;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentAnimation({
    super.extra,
    super.client_id,
    this.animation,
    this.caption,
    this.is_pinned,
  });

  PushMessageContentAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    caption = map['caption'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An audio message
class PushMessageContentAudio extends PushMessageContent {
  String get tdType => 'pushMessageContentAudio';

  /// Message content; may be null
  Audio? audio;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentAudio({
    super.extra,
    super.client_id,
    this.audio,
    this.is_pinned,
  });

  PushMessageContentAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as Audio;
    }
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a user contact
class PushMessageContentContact extends PushMessageContent {
  String get tdType => 'pushMessageContentContact';

  /// Contact's name
  string? name;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentContact({
    super.extra,
    super.client_id,
    this.name,
    this.is_pinned,
  });

  PushMessageContentContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A contact has registered with Telegram
class PushMessageContentContactRegistered extends PushMessageContent {
  String get tdType => 'pushMessageContentContactRegistered';

  PushMessageContentContactRegistered({
    super.extra,
    super.client_id,
  });

  PushMessageContentContactRegistered.fromMap(Map<String, dynamic> map) {
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

/// A document message (a general file)
class PushMessageContentDocument extends PushMessageContent {
  String get tdType => 'pushMessageContentDocument';

  /// Message content; may be null
  Document? document;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentDocument({
    super.extra,
    super.client_id,
    this.document,
    this.is_pinned,
  });

  PushMessageContentDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as Document;
    }
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a game
class PushMessageContentGame extends PushMessageContent {
  String get tdType => 'pushMessageContentGame';

  /// Game title, empty for pinned game message
  string? title;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentGame({
    super.extra,
    super.client_id,
    this.title,
    this.is_pinned,
  });

  PushMessageContentGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A new high score was achieved in a game
class PushMessageContentGameScore extends PushMessageContent {
  String get tdType => 'pushMessageContentGameScore';

  /// Game title, empty for pinned message
  string? title;

  /// New score, 0 for pinned message
  int32? score;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentGameScore({
    super.extra,
    super.client_id,
    this.title,
    this.score,
    this.is_pinned,
  });

  PushMessageContentGameScore.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    score = map['score'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'score': score?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with an invoice from a bot
class PushMessageContentInvoice extends PushMessageContent {
  String get tdType => 'pushMessageContentInvoice';

  /// Product price
  string? price;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentInvoice({
    super.extra,
    super.client_id,
    this.price,
    this.is_pinned,
  });

  PushMessageContentInvoice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    price = map['price'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'price': price?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a location
class PushMessageContentLocation extends PushMessageContent {
  String get tdType => 'pushMessageContentLocation';

  /// True, if the location is live
  Bool? is_live;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentLocation({
    super.extra,
    super.client_id,
    this.is_live,
    this.is_pinned,
  });

  PushMessageContentLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_live = map['is_live'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_live': is_live?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A photo message
class PushMessageContentPhoto extends PushMessageContent {
  String get tdType => 'pushMessageContentPhoto';

  /// Message content; may be null
  Photo? photo;

  /// Photo caption
  string? caption;

  /// True, if the photo is secret
  Bool? is_secret;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentPhoto({
    super.extra,
    super.client_id,
    this.photo,
    this.caption,
    this.is_secret,
    this.is_pinned,
  });

  PushMessageContentPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    caption = map['caption'];
    is_secret = map['is_secret'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a poll
class PushMessageContentPoll extends PushMessageContent {
  String get tdType => 'pushMessageContentPoll';

  /// Poll question
  string? question;

  /// True, if the poll is regular and not in quiz mode
  Bool? is_regular;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentPoll({
    super.extra,
    super.client_id,
    this.question,
    this.is_regular,
    this.is_pinned,
  });

  PushMessageContentPoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    question = map['question'];
    is_regular = map['is_regular'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'question': question?.toMap(skipNulls: skipNulls),
      'is_regular': is_regular?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A screenshot of a message in the chat has been taken
class PushMessageContentScreenshotTaken extends PushMessageContent {
  String get tdType => 'pushMessageContentScreenshotTaken';

  PushMessageContentScreenshotTaken({
    super.extra,
    super.client_id,
  });

  PushMessageContentScreenshotTaken.fromMap(Map<String, dynamic> map) {
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

/// A message with a sticker
class PushMessageContentSticker extends PushMessageContent {
  String get tdType => 'pushMessageContentSticker';

  /// Message content; may be null
  Sticker? sticker;

  /// Emoji corresponding to the sticker; may be empty
  string? emoji;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentSticker({
    super.extra,
    super.client_id,
    this.sticker,
    this.emoji,
    this.is_pinned,
  });

  PushMessageContentSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
    emoji = map['emoji'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a story
class PushMessageContentStory extends PushMessageContent {
  String get tdType => 'pushMessageContentStory';

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentStory({
    super.extra,
    super.client_id,
    this.is_pinned,
  });

  PushMessageContentStory.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A text message
class PushMessageContentText extends PushMessageContent {
  String get tdType => 'pushMessageContentText';

  /// Message text
  string? text;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentText({
    super.extra,
    super.client_id,
    this.text,
    this.is_pinned,
  });

  PushMessageContentText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video message
class PushMessageContentVideo extends PushMessageContent {
  String get tdType => 'pushMessageContentVideo';

  /// Message content; may be null
  Video? video;

  /// Video caption
  string? caption;

  /// True, if the video is secret
  Bool? is_secret;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentVideo({
    super.extra,
    super.client_id,
    this.video,
    this.caption,
    this.is_secret,
    this.is_pinned,
  });

  PushMessageContentVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
    }
    caption = map['caption'];
    is_secret = map['is_secret'];
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video note message
class PushMessageContentVideoNote extends PushMessageContent {
  String get tdType => 'pushMessageContentVideoNote';

  /// Message content; may be null
  VideoNote? video_note;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentVideoNote({
    super.extra,
    super.client_id,
    this.video_note,
    this.is_pinned,
  });

  PushMessageContentVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video_note'] != null) {
      video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
    }
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video_note': video_note?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A voice note message
class PushMessageContentVoiceNote extends PushMessageContent {
  String get tdType => 'pushMessageContentVoiceNote';

  /// Message content; may be null
  VoiceNote? voice_note;

  /// True, if the message is a pinned message with the specified content
  Bool? is_pinned;

  PushMessageContentVoiceNote({
    super.extra,
    super.client_id,
    this.voice_note,
    this.is_pinned,
  });

  PushMessageContentVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    }
    is_pinned = map['is_pinned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'is_pinned': is_pinned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A newly created basic group
class PushMessageContentBasicGroupChatCreate extends PushMessageContent {
  String get tdType => 'pushMessageContentBasicGroupChatCreate';

  PushMessageContentBasicGroupChatCreate({
    super.extra,
    super.client_id,
  });

  PushMessageContentBasicGroupChatCreate.fromMap(Map<String, dynamic> map) {
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

/// New chat members were invited to a group
class PushMessageContentChatAddMembers extends PushMessageContent {
  String get tdType => 'pushMessageContentChatAddMembers';

  /// Name of the added member
  string? member_name;

  /// True, if the current user was added to the group
  Bool? is_current_user;

  /// True, if the user has returned to the group themselves
  Bool? is_returned;

  PushMessageContentChatAddMembers({
    super.extra,
    super.client_id,
    this.member_name,
    this.is_current_user,
    this.is_returned,
  });

  PushMessageContentChatAddMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    member_name = map['member_name'];
    is_current_user = map['is_current_user'];
    is_returned = map['is_returned'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'member_name': member_name?.toMap(skipNulls: skipNulls),
      'is_current_user': is_current_user?.toMap(skipNulls: skipNulls),
      'is_returned': is_returned?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat photo was edited
class PushMessageContentChatChangePhoto extends PushMessageContent {
  String get tdType => 'pushMessageContentChatChangePhoto';

  PushMessageContentChatChangePhoto({
    super.extra,
    super.client_id,
  });

  PushMessageContentChatChangePhoto.fromMap(Map<String, dynamic> map) {
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

/// A chat title was edited
class PushMessageContentChatChangeTitle extends PushMessageContent {
  String get tdType => 'pushMessageContentChatChangeTitle';

  /// New chat title
  string? title;

  PushMessageContentChatChangeTitle({
    super.extra,
    super.client_id,
    this.title,
  });

  PushMessageContentChatChangeTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat background was edited
class PushMessageContentChatSetBackground extends PushMessageContent {
  String get tdType => 'pushMessageContentChatSetBackground';

  /// True, if the set background is the same as the background of the current user
  Bool? is_same;

  PushMessageContentChatSetBackground({
    super.extra,
    super.client_id,
    this.is_same,
  });

  PushMessageContentChatSetBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_same = map['is_same'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_same': is_same?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat theme was edited
class PushMessageContentChatSetTheme extends PushMessageContent {
  String get tdType => 'pushMessageContentChatSetTheme';

  /// If non-empty, name of a new theme, set for the chat. Otherwise, the chat theme was reset to the default one
  string? theme_name;

  PushMessageContentChatSetTheme({
    super.extra,
    super.client_id,
    this.theme_name,
  });

  PushMessageContentChatSetTheme.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    theme_name = map['theme_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'theme_name': theme_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A chat member was deleted
class PushMessageContentChatDeleteMember extends PushMessageContent {
  String get tdType => 'pushMessageContentChatDeleteMember';

  /// Name of the deleted member
  string? member_name;

  /// True, if the current user was deleted from the group
  Bool? is_current_user;

  /// True, if the user has left the group themselves
  Bool? is_left;

  PushMessageContentChatDeleteMember({
    super.extra,
    super.client_id,
    this.member_name,
    this.is_current_user,
    this.is_left,
  });

  PushMessageContentChatDeleteMember.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    member_name = map['member_name'];
    is_current_user = map['is_current_user'];
    is_left = map['is_left'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'member_name': member_name?.toMap(skipNulls: skipNulls),
      'is_current_user': is_current_user?.toMap(skipNulls: skipNulls),
      'is_left': is_left?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A new member joined the chat via an invite link
class PushMessageContentChatJoinByLink extends PushMessageContent {
  String get tdType => 'pushMessageContentChatJoinByLink';

  PushMessageContentChatJoinByLink({
    super.extra,
    super.client_id,
  });

  PushMessageContentChatJoinByLink.fromMap(Map<String, dynamic> map) {
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

/// A new member was accepted to the chat by an administrator
class PushMessageContentChatJoinByRequest extends PushMessageContent {
  String get tdType => 'pushMessageContentChatJoinByRequest';

  PushMessageContentChatJoinByRequest({
    super.extra,
    super.client_id,
  });

  PushMessageContentChatJoinByRequest.fromMap(Map<String, dynamic> map) {
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

/// A new recurring payment was made by the current user
class PushMessageContentRecurringPayment extends PushMessageContent {
  String get tdType => 'pushMessageContentRecurringPayment';

  /// The paid amount
  string? amount;

  PushMessageContentRecurringPayment({
    super.extra,
    super.client_id,
    this.amount,
  });

  PushMessageContentRecurringPayment.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    amount = map['amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'amount': amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A profile photo was suggested to the user
class PushMessageContentSuggestProfilePhoto extends PushMessageContent {
  String get tdType => 'pushMessageContentSuggestProfilePhoto';

  PushMessageContentSuggestProfilePhoto({
    super.extra,
    super.client_id,
  });

  PushMessageContentSuggestProfilePhoto.fromMap(Map<String, dynamic> map) {
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

/// A forwarded messages
class PushMessageContentMessageForwards extends PushMessageContent {
  String get tdType => 'pushMessageContentMessageForwards';

  /// Number of forwarded messages
  int32? total_count;

  PushMessageContentMessageForwards({
    super.extra,
    super.client_id,
    this.total_count,
  });

  PushMessageContentMessageForwards.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A media album
class PushMessageContentMediaAlbum extends PushMessageContent {
  String get tdType => 'pushMessageContentMediaAlbum';

  /// Number of messages in the album
  int32? total_count;

  /// True, if the album has at least one photo
  Bool? has_photos;

  /// True, if the album has at least one video file
  Bool? has_videos;

  /// True, if the album has at least one audio file
  Bool? has_audios;

  /// True, if the album has at least one document
  Bool? has_documents;

  PushMessageContentMediaAlbum({
    super.extra,
    super.client_id,
    this.total_count,
    this.has_photos,
    this.has_videos,
    this.has_audios,
    this.has_documents,
  });

  PushMessageContentMediaAlbum.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    total_count = map['total_count'];
    has_photos = map['has_photos'];
    has_videos = map['has_videos'];
    has_audios = map['has_audios'];
    has_documents = map['has_documents'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'total_count': total_count?.toMap(skipNulls: skipNulls),
      'has_photos': has_photos?.toMap(skipNulls: skipNulls),
      'has_videos': has_videos?.toMap(skipNulls: skipNulls),
      'has_audios': has_audios?.toMap(skipNulls: skipNulls),
      'has_documents': has_documents?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
