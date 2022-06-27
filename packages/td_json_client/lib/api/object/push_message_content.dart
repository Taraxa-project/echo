import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/video_note.dart';
import 'package:td_json_client/api/object/voice_note.dart';

abstract class PushMessageContent extends TdObject {}

class PushMessageContentHidden extends PushMessageContent {
  String get tdType => 'pushMessageContentHidden';

  String? extra;
  int? client_id;
  Bool? is_pinned;

  PushMessageContentHidden({
    this.extra,
    this.client_id,
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
class PushMessageContentAnimation extends PushMessageContent {
  String get tdType => 'pushMessageContentAnimation';

  String? extra;
  int? client_id;
  Animation? animation;
  string? caption;
  Bool? is_pinned;

  PushMessageContentAnimation({
    this.extra,
    this.client_id,
    this.animation,
    this.caption,
    this.is_pinned,
  });

  PushMessageContentAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    animation = TdApiMap.fromMap(map['animation']) as Animation;
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
class PushMessageContentAudio extends PushMessageContent {
  String get tdType => 'pushMessageContentAudio';

  String? extra;
  int? client_id;
  Audio? audio;
  Bool? is_pinned;

  PushMessageContentAudio({
    this.extra,
    this.client_id,
    this.audio,
    this.is_pinned,
  });

  PushMessageContentAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    audio = TdApiMap.fromMap(map['audio']) as Audio;
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
class PushMessageContentContact extends PushMessageContent {
  String get tdType => 'pushMessageContentContact';

  String? extra;
  int? client_id;
  string? name;
  Bool? is_pinned;

  PushMessageContentContact({
    this.extra,
    this.client_id,
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
class PushMessageContentContactRegistered extends PushMessageContent {
  String get tdType => 'pushMessageContentContactRegistered';

  String? extra;
  int? client_id;

  PushMessageContentContactRegistered({
    this.extra,
    this.client_id,
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
class PushMessageContentDocument extends PushMessageContent {
  String get tdType => 'pushMessageContentDocument';

  String? extra;
  int? client_id;
  Document? document;
  Bool? is_pinned;

  PushMessageContentDocument({
    this.extra,
    this.client_id,
    this.document,
    this.is_pinned,
  });

  PushMessageContentDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    document = TdApiMap.fromMap(map['document']) as Document;
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
class PushMessageContentGame extends PushMessageContent {
  String get tdType => 'pushMessageContentGame';

  String? extra;
  int? client_id;
  string? title;
  Bool? is_pinned;

  PushMessageContentGame({
    this.extra,
    this.client_id,
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
class PushMessageContentGameScore extends PushMessageContent {
  String get tdType => 'pushMessageContentGameScore';

  String? extra;
  int? client_id;
  string? title;
  int32? score;
  Bool? is_pinned;

  PushMessageContentGameScore({
    this.extra,
    this.client_id,
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
class PushMessageContentInvoice extends PushMessageContent {
  String get tdType => 'pushMessageContentInvoice';

  String? extra;
  int? client_id;
  string? price;
  Bool? is_pinned;

  PushMessageContentInvoice({
    this.extra,
    this.client_id,
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
class PushMessageContentLocation extends PushMessageContent {
  String get tdType => 'pushMessageContentLocation';

  String? extra;
  int? client_id;
  Bool? is_live;
  Bool? is_pinned;

  PushMessageContentLocation({
    this.extra,
    this.client_id,
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
class PushMessageContentPhoto extends PushMessageContent {
  String get tdType => 'pushMessageContentPhoto';

  String? extra;
  int? client_id;
  Photo? photo;
  string? caption;
  Bool? is_secret;
  Bool? is_pinned;

  PushMessageContentPhoto({
    this.extra,
    this.client_id,
    this.photo,
    this.caption,
    this.is_secret,
    this.is_pinned,
  });

  PushMessageContentPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
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
class PushMessageContentPoll extends PushMessageContent {
  String get tdType => 'pushMessageContentPoll';

  String? extra;
  int? client_id;
  string? question;
  Bool? is_regular;
  Bool? is_pinned;

  PushMessageContentPoll({
    this.extra,
    this.client_id,
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
class PushMessageContentScreenshotTaken extends PushMessageContent {
  String get tdType => 'pushMessageContentScreenshotTaken';

  String? extra;
  int? client_id;

  PushMessageContentScreenshotTaken({
    this.extra,
    this.client_id,
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
class PushMessageContentSticker extends PushMessageContent {
  String get tdType => 'pushMessageContentSticker';

  String? extra;
  int? client_id;
  Sticker? sticker;
  string? emoji;
  Bool? is_pinned;

  PushMessageContentSticker({
    this.extra,
    this.client_id,
    this.sticker,
    this.emoji,
    this.is_pinned,
  });

  PushMessageContentSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
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
class PushMessageContentText extends PushMessageContent {
  String get tdType => 'pushMessageContentText';

  String? extra;
  int? client_id;
  string? text;
  Bool? is_pinned;

  PushMessageContentText({
    this.extra,
    this.client_id,
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
class PushMessageContentVideo extends PushMessageContent {
  String get tdType => 'pushMessageContentVideo';

  String? extra;
  int? client_id;
  Video? video;
  string? caption;
  Bool? is_secret;
  Bool? is_pinned;

  PushMessageContentVideo({
    this.extra,
    this.client_id,
    this.video,
    this.caption,
    this.is_secret,
    this.is_pinned,
  });

  PushMessageContentVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    video = TdApiMap.fromMap(map['video']) as Video;
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
class PushMessageContentVideoNote extends PushMessageContent {
  String get tdType => 'pushMessageContentVideoNote';

  String? extra;
  int? client_id;
  VideoNote? video_note;
  Bool? is_pinned;

  PushMessageContentVideoNote({
    this.extra,
    this.client_id,
    this.video_note,
    this.is_pinned,
  });

  PushMessageContentVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
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
class PushMessageContentVoiceNote extends PushMessageContent {
  String get tdType => 'pushMessageContentVoiceNote';

  String? extra;
  int? client_id;
  VoiceNote? voice_note;
  Bool? is_pinned;

  PushMessageContentVoiceNote({
    this.extra,
    this.client_id,
    this.voice_note,
    this.is_pinned,
  });

  PushMessageContentVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
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
class PushMessageContentBasicGroupChatCreate extends PushMessageContent {
  String get tdType => 'pushMessageContentBasicGroupChatCreate';

  String? extra;
  int? client_id;

  PushMessageContentBasicGroupChatCreate({
    this.extra,
    this.client_id,
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
class PushMessageContentChatAddMembers extends PushMessageContent {
  String get tdType => 'pushMessageContentChatAddMembers';

  String? extra;
  int? client_id;
  string? member_name;
  Bool? is_current_user;
  Bool? is_returned;

  PushMessageContentChatAddMembers({
    this.extra,
    this.client_id,
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
class PushMessageContentChatChangePhoto extends PushMessageContent {
  String get tdType => 'pushMessageContentChatChangePhoto';

  String? extra;
  int? client_id;

  PushMessageContentChatChangePhoto({
    this.extra,
    this.client_id,
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
class PushMessageContentChatChangeTitle extends PushMessageContent {
  String get tdType => 'pushMessageContentChatChangeTitle';

  String? extra;
  int? client_id;
  string? title;

  PushMessageContentChatChangeTitle({
    this.extra,
    this.client_id,
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
class PushMessageContentChatSetTheme extends PushMessageContent {
  String get tdType => 'pushMessageContentChatSetTheme';

  String? extra;
  int? client_id;
  string? theme_name;

  PushMessageContentChatSetTheme({
    this.extra,
    this.client_id,
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
class PushMessageContentChatDeleteMember extends PushMessageContent {
  String get tdType => 'pushMessageContentChatDeleteMember';

  String? extra;
  int? client_id;
  string? member_name;
  Bool? is_current_user;
  Bool? is_left;

  PushMessageContentChatDeleteMember({
    this.extra,
    this.client_id,
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
class PushMessageContentChatJoinByLink extends PushMessageContent {
  String get tdType => 'pushMessageContentChatJoinByLink';

  String? extra;
  int? client_id;

  PushMessageContentChatJoinByLink({
    this.extra,
    this.client_id,
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
class PushMessageContentChatJoinByRequest extends PushMessageContent {
  String get tdType => 'pushMessageContentChatJoinByRequest';

  String? extra;
  int? client_id;

  PushMessageContentChatJoinByRequest({
    this.extra,
    this.client_id,
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
class PushMessageContentMessageForwards extends PushMessageContent {
  String get tdType => 'pushMessageContentMessageForwards';

  String? extra;
  int? client_id;
  int32? total_count;

  PushMessageContentMessageForwards({
    this.extra,
    this.client_id,
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
class PushMessageContentMediaAlbum extends PushMessageContent {
  String get tdType => 'pushMessageContentMediaAlbum';

  String? extra;
  int? client_id;
  int32? total_count;
  Bool? has_photos;
  Bool? has_videos;
  Bool? has_audios;
  Bool? has_documents;

  PushMessageContentMediaAlbum({
    this.extra,
    this.client_id,
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
