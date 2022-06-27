import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/web_page.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/video_note.dart';
import 'package:td_json_client/api/object/voice_note.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/animated_emoji.dart';
import 'package:td_json_client/api/object/dice_stickers.dart';
import 'package:td_json_client/api/object/game.dart';
import 'package:td_json_client/api/object/poll.dart';
import 'package:td_json_client/api/object/call_discard_reason.dart';
import 'package:td_json_client/api/object/chat_photo.dart';
import 'package:td_json_client/api/object/order_info.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';
import 'package:td_json_client/api/object/encrypted_passport_element.dart';
import 'package:td_json_client/api/object/encrypted_credentials.dart';
import 'package:td_json_client/api/object/message_sender.dart';

abstract class MessageContent extends TdObject {}

class MessageText extends MessageContent {
  String get tdType => 'messageText';

  string? extra;
  int? client_id;
  FormattedText? text;
  WebPage? web_page;

  MessageText({
    this.extra,
    this.client_id,
    this.text,
    this.web_page,
  });

  MessageText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as FormattedText;
    web_page = TdApiMap.fromMap(map['web_page']) as WebPage;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'web_page': web_page?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageAnimation extends MessageContent {
  String get tdType => 'messageAnimation';

  string? extra;
  int? client_id;
  Animation? animation;
  FormattedText? caption;
  Bool? is_secret;

  MessageAnimation({
    this.extra,
    this.client_id,
    this.animation,
    this.caption,
    this.is_secret,
  });

  MessageAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    animation = TdApiMap.fromMap(map['animation']) as Animation;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    is_secret = map['is_secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageAudio extends MessageContent {
  String get tdType => 'messageAudio';

  string? extra;
  int? client_id;
  Audio? audio;
  FormattedText? caption;

  MessageAudio({
    this.extra,
    this.client_id,
    this.audio,
    this.caption,
  });

  MessageAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    audio = TdApiMap.fromMap(map['audio']) as Audio;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageDocument extends MessageContent {
  String get tdType => 'messageDocument';

  string? extra;
  int? client_id;
  Document? document;
  FormattedText? caption;

  MessageDocument({
    this.extra,
    this.client_id,
    this.document,
    this.caption,
  });

  MessageDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    document = TdApiMap.fromMap(map['document']) as Document;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePhoto extends MessageContent {
  String get tdType => 'messagePhoto';

  string? extra;
  int? client_id;
  Photo? photo;
  FormattedText? caption;
  Bool? is_secret;

  MessagePhoto({
    this.extra,
    this.client_id,
    this.photo,
    this.caption,
    this.is_secret,
  });

  MessagePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    is_secret = map['is_secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageExpiredPhoto extends MessageContent {
  String get tdType => 'messageExpiredPhoto';

  string? extra;
  int? client_id;

  MessageExpiredPhoto({
    this.extra,
    this.client_id,
  });

  MessageExpiredPhoto.fromMap(Map<String, dynamic> map) {
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
class MessageSticker extends MessageContent {
  String get tdType => 'messageSticker';

  string? extra;
  int? client_id;
  Sticker? sticker;

  MessageSticker({
    this.extra,
    this.client_id,
    this.sticker,
  });

  MessageSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVideo extends MessageContent {
  String get tdType => 'messageVideo';

  string? extra;
  int? client_id;
  Video? video;
  FormattedText? caption;
  Bool? is_secret;

  MessageVideo({
    this.extra,
    this.client_id,
    this.video,
    this.caption,
    this.is_secret,
  });

  MessageVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    video = TdApiMap.fromMap(map['video']) as Video;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    is_secret = map['is_secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageExpiredVideo extends MessageContent {
  String get tdType => 'messageExpiredVideo';

  string? extra;
  int? client_id;

  MessageExpiredVideo({
    this.extra,
    this.client_id,
  });

  MessageExpiredVideo.fromMap(Map<String, dynamic> map) {
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
class MessageVideoNote extends MessageContent {
  String get tdType => 'messageVideoNote';

  string? extra;
  int? client_id;
  VideoNote? video_note;
  Bool? is_viewed;
  Bool? is_secret;

  MessageVideoNote({
    this.extra,
    this.client_id,
    this.video_note,
    this.is_viewed,
    this.is_secret,
  });

  MessageVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
    is_viewed = map['is_viewed'];
    is_secret = map['is_secret'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video_note': video_note?.toMap(skipNulls: skipNulls),
      'is_viewed': is_viewed?.toMap(skipNulls: skipNulls),
      'is_secret': is_secret?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVoiceNote extends MessageContent {
  String get tdType => 'messageVoiceNote';

  string? extra;
  int? client_id;
  VoiceNote? voice_note;
  FormattedText? caption;
  Bool? is_listened;

  MessageVoiceNote({
    this.extra,
    this.client_id,
    this.voice_note,
    this.caption,
    this.is_listened,
  });

  MessageVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    is_listened = map['is_listened'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_listened': is_listened?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageLocation extends MessageContent {
  String get tdType => 'messageLocation';

  string? extra;
  int? client_id;
  Location? location;
  int32? live_period;
  int32? expires_in;
  int32? heading;
  int32? proximity_alert_radius;

  MessageLocation({
    this.extra,
    this.client_id,
    this.location,
    this.live_period,
    this.expires_in,
    this.heading,
    this.proximity_alert_radius,
  });

  MessageLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    location = TdApiMap.fromMap(map['location']) as Location;
    live_period = map['live_period'];
    expires_in = map['expires_in'];
    heading = map['heading'];
    proximity_alert_radius = map['proximity_alert_radius'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'live_period': live_period?.toMap(skipNulls: skipNulls),
      'expires_in': expires_in?.toMap(skipNulls: skipNulls),
      'heading': heading?.toMap(skipNulls: skipNulls),
      'proximity_alert_radius': proximity_alert_radius?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVenue extends MessageContent {
  String get tdType => 'messageVenue';

  string? extra;
  int? client_id;
  Venue? venue;

  MessageVenue({
    this.extra,
    this.client_id,
    this.venue,
  });

  MessageVenue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    venue = TdApiMap.fromMap(map['venue']) as Venue;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'venue': venue?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageContact extends MessageContent {
  String get tdType => 'messageContact';

  string? extra;
  int? client_id;
  Contact? contact;

  MessageContact({
    this.extra,
    this.client_id,
    this.contact,
  });

  MessageContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    contact = TdApiMap.fromMap(map['contact']) as Contact;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'contact': contact?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageAnimatedEmoji extends MessageContent {
  String get tdType => 'messageAnimatedEmoji';

  string? extra;
  int? client_id;
  AnimatedEmoji? animated_emoji;
  string? emoji;

  MessageAnimatedEmoji({
    this.extra,
    this.client_id,
    this.animated_emoji,
    this.emoji,
  });

  MessageAnimatedEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    animated_emoji = TdApiMap.fromMap(map['animated_emoji']) as AnimatedEmoji;
    emoji = map['emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animated_emoji': animated_emoji?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageDice extends MessageContent {
  String get tdType => 'messageDice';

  string? extra;
  int? client_id;
  DiceStickers? initial_state;
  DiceStickers? final_state;
  string? emoji;
  int32? value;
  int32? success_animation_frame_number;

  MessageDice({
    this.extra,
    this.client_id,
    this.initial_state,
    this.final_state,
    this.emoji,
    this.value,
    this.success_animation_frame_number,
  });

  MessageDice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    initial_state = TdApiMap.fromMap(map['initial_state']) as DiceStickers;
    final_state = TdApiMap.fromMap(map['final_state']) as DiceStickers;
    emoji = map['emoji'];
    value = map['value'];
    success_animation_frame_number = map['success_animation_frame_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'initial_state': initial_state?.toMap(skipNulls: skipNulls),
      'final_state': final_state?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
      'success_animation_frame_number': success_animation_frame_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageGame extends MessageContent {
  String get tdType => 'messageGame';

  string? extra;
  int? client_id;
  Game? game;

  MessageGame({
    this.extra,
    this.client_id,
    this.game,
  });

  MessageGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    game = TdApiMap.fromMap(map['game']) as Game;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'game': game?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePoll extends MessageContent {
  String get tdType => 'messagePoll';

  string? extra;
  int? client_id;
  Poll? poll;

  MessagePoll({
    this.extra,
    this.client_id,
    this.poll,
  });

  MessagePoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    poll = TdApiMap.fromMap(map['poll']) as Poll;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'poll': poll?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageInvoice extends MessageContent {
  String get tdType => 'messageInvoice';

  string? extra;
  int? client_id;
  string? title;
  string? description;
  Photo? photo;
  string? currency;
  int53? total_amount;
  string? start_parameter;
  Bool? is_test;
  Bool? need_shipping_address;
  int53? receipt_message_id;

  MessageInvoice({
    this.extra,
    this.client_id,
    this.title,
    this.description,
    this.photo,
    this.currency,
    this.total_amount,
    this.start_parameter,
    this.is_test,
    this.need_shipping_address,
    this.receipt_message_id,
  });

  MessageInvoice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    description = map['description'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
    currency = map['currency'];
    total_amount = map['total_amount'];
    start_parameter = map['start_parameter'];
    is_test = map['is_test'];
    need_shipping_address = map['need_shipping_address'];
    receipt_message_id = map['receipt_message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'total_amount': total_amount?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
      'is_test': is_test?.toMap(skipNulls: skipNulls),
      'need_shipping_address': need_shipping_address?.toMap(skipNulls: skipNulls),
      'receipt_message_id': receipt_message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageCall extends MessageContent {
  String get tdType => 'messageCall';

  string? extra;
  int? client_id;
  Bool? is_video;
  CallDiscardReason? discard_reason;
  int32? duration;

  MessageCall({
    this.extra,
    this.client_id,
    this.is_video,
    this.discard_reason,
    this.duration,
  });

  MessageCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_video = map['is_video'];
    discard_reason = TdApiMap.fromMap(map['discard_reason']) as CallDiscardReason;
    duration = map['duration'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'is_video': is_video?.toMap(skipNulls: skipNulls),
      'discard_reason': discard_reason?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVideoChatScheduled extends MessageContent {
  String get tdType => 'messageVideoChatScheduled';

  string? extra;
  int? client_id;
  int32? group_call_id;
  int32? start_date;

  MessageVideoChatScheduled({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.start_date,
  });

  MessageVideoChatScheduled.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    start_date = map['start_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'start_date': start_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVideoChatStarted extends MessageContent {
  String get tdType => 'messageVideoChatStarted';

  string? extra;
  int? client_id;
  int32? group_call_id;

  MessageVideoChatStarted({
    this.extra,
    this.client_id,
    this.group_call_id,
  });

  MessageVideoChatStarted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageVideoChatEnded extends MessageContent {
  String get tdType => 'messageVideoChatEnded';

  string? extra;
  int? client_id;
  int32? duration;

  MessageVideoChatEnded({
    this.extra,
    this.client_id,
    this.duration,
  });

  MessageVideoChatEnded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    duration = map['duration'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageInviteVideoChatParticipants extends MessageContent {
  String get tdType => 'messageInviteVideoChatParticipants';

  string? extra;
  int? client_id;
  int32? group_call_id;
  vector<int53>? user_ids;

  MessageInviteVideoChatParticipants({
    this.extra,
    this.client_id,
    this.group_call_id,
    this.user_ids,
  });

  MessageInviteVideoChatParticipants.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['user_ids']) {
      user_ids = [];
      for (var someValue in map['user_ids']) {
        user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'group_call_id': group_call_id?.toMap(skipNulls: skipNulls),
      'user_ids': user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageBasicGroupChatCreate extends MessageContent {
  String get tdType => 'messageBasicGroupChatCreate';

  string? extra;
  int? client_id;
  string? title;
  vector<int53>? member_user_ids;

  MessageBasicGroupChatCreate({
    this.extra,
    this.client_id,
    this.title,
    this.member_user_ids,
  });

  MessageBasicGroupChatCreate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    if (map['member_user_ids']) {
      member_user_ids = [];
      for (var someValue in map['member_user_ids']) {
        member_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'member_user_ids': member_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageSupergroupChatCreate extends MessageContent {
  String get tdType => 'messageSupergroupChatCreate';

  string? extra;
  int? client_id;
  string? title;

  MessageSupergroupChatCreate({
    this.extra,
    this.client_id,
    this.title,
  });

  MessageSupergroupChatCreate.fromMap(Map<String, dynamic> map) {
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
class MessageChatChangeTitle extends MessageContent {
  String get tdType => 'messageChatChangeTitle';

  string? extra;
  int? client_id;
  string? title;

  MessageChatChangeTitle({
    this.extra,
    this.client_id,
    this.title,
  });

  MessageChatChangeTitle.fromMap(Map<String, dynamic> map) {
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
class MessageChatChangePhoto extends MessageContent {
  String get tdType => 'messageChatChangePhoto';

  string? extra;
  int? client_id;
  ChatPhoto? photo;

  MessageChatChangePhoto({
    this.extra,
    this.client_id,
    this.photo,
  });

  MessageChatChangePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageChatDeletePhoto extends MessageContent {
  String get tdType => 'messageChatDeletePhoto';

  string? extra;
  int? client_id;

  MessageChatDeletePhoto({
    this.extra,
    this.client_id,
  });

  MessageChatDeletePhoto.fromMap(Map<String, dynamic> map) {
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
class MessageChatAddMembers extends MessageContent {
  String get tdType => 'messageChatAddMembers';

  string? extra;
  int? client_id;
  vector<int53>? member_user_ids;

  MessageChatAddMembers({
    this.extra,
    this.client_id,
    this.member_user_ids,
  });

  MessageChatAddMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['member_user_ids']) {
      member_user_ids = [];
      for (var someValue in map['member_user_ids']) {
        member_user_ids?.add(someValue);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'member_user_ids': member_user_ids?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageChatJoinByLink extends MessageContent {
  String get tdType => 'messageChatJoinByLink';

  string? extra;
  int? client_id;

  MessageChatJoinByLink({
    this.extra,
    this.client_id,
  });

  MessageChatJoinByLink.fromMap(Map<String, dynamic> map) {
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
class MessageChatJoinByRequest extends MessageContent {
  String get tdType => 'messageChatJoinByRequest';

  string? extra;
  int? client_id;

  MessageChatJoinByRequest({
    this.extra,
    this.client_id,
  });

  MessageChatJoinByRequest.fromMap(Map<String, dynamic> map) {
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
class MessageChatDeleteMember extends MessageContent {
  String get tdType => 'messageChatDeleteMember';

  string? extra;
  int? client_id;
  int53? user_id;

  MessageChatDeleteMember({
    this.extra,
    this.client_id,
    this.user_id,
  });

  MessageChatDeleteMember.fromMap(Map<String, dynamic> map) {
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
class MessageChatUpgradeTo extends MessageContent {
  String get tdType => 'messageChatUpgradeTo';

  string? extra;
  int? client_id;
  int53? supergroup_id;

  MessageChatUpgradeTo({
    this.extra,
    this.client_id,
    this.supergroup_id,
  });

  MessageChatUpgradeTo.fromMap(Map<String, dynamic> map) {
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
class MessageChatUpgradeFrom extends MessageContent {
  String get tdType => 'messageChatUpgradeFrom';

  string? extra;
  int? client_id;
  string? title;
  int53? basic_group_id;

  MessageChatUpgradeFrom({
    this.extra,
    this.client_id,
    this.title,
    this.basic_group_id,
  });

  MessageChatUpgradeFrom.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    basic_group_id = map['basic_group_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePinMessage extends MessageContent {
  String get tdType => 'messagePinMessage';

  string? extra;
  int? client_id;
  int53? message_id;

  MessagePinMessage({
    this.extra,
    this.client_id,
    this.message_id,
  });

  MessagePinMessage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    message_id = map['message_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageScreenshotTaken extends MessageContent {
  String get tdType => 'messageScreenshotTaken';

  string? extra;
  int? client_id;

  MessageScreenshotTaken({
    this.extra,
    this.client_id,
  });

  MessageScreenshotTaken.fromMap(Map<String, dynamic> map) {
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
class MessageChatSetTheme extends MessageContent {
  String get tdType => 'messageChatSetTheme';

  string? extra;
  int? client_id;
  string? theme_name;

  MessageChatSetTheme({
    this.extra,
    this.client_id,
    this.theme_name,
  });

  MessageChatSetTheme.fromMap(Map<String, dynamic> map) {
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
class MessageChatSetTtl extends MessageContent {
  String get tdType => 'messageChatSetTtl';

  string? extra;
  int? client_id;
  int32? ttl;

  MessageChatSetTtl({
    this.extra,
    this.client_id,
    this.ttl,
  });

  MessageChatSetTtl.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    ttl = map['ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageCustomServiceAction extends MessageContent {
  String get tdType => 'messageCustomServiceAction';

  string? extra;
  int? client_id;
  string? text;

  MessageCustomServiceAction({
    this.extra,
    this.client_id,
    this.text,
  });

  MessageCustomServiceAction.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = map['text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageGameScore extends MessageContent {
  String get tdType => 'messageGameScore';

  string? extra;
  int? client_id;
  int53? game_message_id;
  int64? game_id;
  int32? score;

  MessageGameScore({
    this.extra,
    this.client_id,
    this.game_message_id,
    this.game_id,
    this.score,
  });

  MessageGameScore.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    game_message_id = map['game_message_id'];
    game_id = map['game_id'];
    score = map['score'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'game_message_id': game_message_id?.toMap(skipNulls: skipNulls),
      'game_id': game_id?.toMap(skipNulls: skipNulls),
      'score': score?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePaymentSuccessful extends MessageContent {
  String get tdType => 'messagePaymentSuccessful';

  string? extra;
  int? client_id;
  int53? invoice_chat_id;
  int53? invoice_message_id;
  string? currency;
  int53? total_amount;

  MessagePaymentSuccessful({
    this.extra,
    this.client_id,
    this.invoice_chat_id,
    this.invoice_message_id,
    this.currency,
    this.total_amount,
  });

  MessagePaymentSuccessful.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invoice_chat_id = map['invoice_chat_id'];
    invoice_message_id = map['invoice_message_id'];
    currency = map['currency'];
    total_amount = map['total_amount'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invoice_chat_id': invoice_chat_id?.toMap(skipNulls: skipNulls),
      'invoice_message_id': invoice_message_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'total_amount': total_amount?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePaymentSuccessfulBot extends MessageContent {
  String get tdType => 'messagePaymentSuccessfulBot';

  string? extra;
  int? client_id;
  string? currency;
  int53? total_amount;
  bytes? invoice_payload;
  string? shipping_option_id;
  OrderInfo? order_info;
  string? telegram_payment_charge_id;
  string? provider_payment_charge_id;

  MessagePaymentSuccessfulBot({
    this.extra,
    this.client_id,
    this.currency,
    this.total_amount,
    this.invoice_payload,
    this.shipping_option_id,
    this.order_info,
    this.telegram_payment_charge_id,
    this.provider_payment_charge_id,
  });

  MessagePaymentSuccessfulBot.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    currency = map['currency'];
    total_amount = map['total_amount'];
    invoice_payload = map['invoice_payload'];
    shipping_option_id = map['shipping_option_id'];
    order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    telegram_payment_charge_id = map['telegram_payment_charge_id'];
    provider_payment_charge_id = map['provider_payment_charge_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'total_amount': total_amount?.toMap(skipNulls: skipNulls),
      'invoice_payload': invoice_payload?.toMap(skipNulls: skipNulls),
      'shipping_option_id': shipping_option_id?.toMap(skipNulls: skipNulls),
      'order_info': order_info?.toMap(skipNulls: skipNulls),
      'telegram_payment_charge_id': telegram_payment_charge_id?.toMap(skipNulls: skipNulls),
      'provider_payment_charge_id': provider_payment_charge_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageContactRegistered extends MessageContent {
  String get tdType => 'messageContactRegistered';

  string? extra;
  int? client_id;

  MessageContactRegistered({
    this.extra,
    this.client_id,
  });

  MessageContactRegistered.fromMap(Map<String, dynamic> map) {
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
class MessageWebsiteConnected extends MessageContent {
  String get tdType => 'messageWebsiteConnected';

  string? extra;
  int? client_id;
  string? domain_name;

  MessageWebsiteConnected({
    this.extra,
    this.client_id,
    this.domain_name,
  });

  MessageWebsiteConnected.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    domain_name = map['domain_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'domain_name': domain_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePassportDataSent extends MessageContent {
  String get tdType => 'messagePassportDataSent';

  string? extra;
  int? client_id;
  vector<PassportElementType>? types;

  MessagePassportDataSent({
    this.extra,
    this.client_id,
    this.types,
  });

  MessagePassportDataSent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['types']) {
      types = [];
      for (var someValue in map['types']) {
        types?.add(TdApiMap.fromMap(someValue) as PassportElementType);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'types': types?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessagePassportDataReceived extends MessageContent {
  String get tdType => 'messagePassportDataReceived';

  string? extra;
  int? client_id;
  vector<EncryptedPassportElement>? elements;
  EncryptedCredentials? credentials;

  MessagePassportDataReceived({
    this.extra,
    this.client_id,
    this.elements,
    this.credentials,
  });

  MessagePassportDataReceived.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['elements']) {
      elements = [];
      for (var someValue in map['elements']) {
        elements?.add(TdApiMap.fromMap(someValue) as EncryptedPassportElement);
      }
    }
    credentials = TdApiMap.fromMap(map['credentials']) as EncryptedCredentials;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'elements': elements?.toMap(skipNulls: skipNulls),
      'credentials': credentials?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageProximityAlertTriggered extends MessageContent {
  String get tdType => 'messageProximityAlertTriggered';

  string? extra;
  int? client_id;
  MessageSender? traveler_id;
  MessageSender? watcher_id;
  int32? distance;

  MessageProximityAlertTriggered({
    this.extra,
    this.client_id,
    this.traveler_id,
    this.watcher_id,
    this.distance,
  });

  MessageProximityAlertTriggered.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    traveler_id = TdApiMap.fromMap(map['traveler_id']) as MessageSender;
    watcher_id = TdApiMap.fromMap(map['watcher_id']) as MessageSender;
    distance = map['distance'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'traveler_id': traveler_id?.toMap(skipNulls: skipNulls),
      'watcher_id': watcher_id?.toMap(skipNulls: skipNulls),
      'distance': distance?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class MessageUnsupported extends MessageContent {
  String get tdType => 'messageUnsupported';

  string? extra;
  int? client_id;

  MessageUnsupported({
    this.extra,
    this.client_id,
  });

  MessageUnsupported.fromMap(Map<String, dynamic> map) {
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
