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

/// Contains the content of a message
abstract class MessageContent extends TdObject {
  MessageContent({super.extra, super.client_id});
}


/// A text message 
class MessageText extends MessageContent {
  String get tdType => 'messageText';


  /// Text of the message 
  FormattedText? text;

  /// A preview of the web page that's mentioned in the text; may be null
  WebPage? web_page;

  MessageText({
    super.extra,
    super.client_id,
    this.text,
    this.web_page,
  });

  MessageText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
    if (map['web_page'] != null) {
      web_page = TdApiMap.fromMap(map['web_page']) as WebPage;
    }
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

/// An animation message (GIF-style). 
class MessageAnimation extends MessageContent {
  String get tdType => 'messageAnimation';


  /// The animation description 
  Animation? animation;

  /// Animation caption 
  FormattedText? caption;

  /// True, if the animation thumbnail must be blurred and the animation must be shown only while tapped
  Bool? is_secret;

  MessageAnimation({
    super.extra,
    super.client_id,
    this.animation,
    this.caption,
    this.is_secret,
  });

  MessageAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// An audio message 
class MessageAudio extends MessageContent {
  String get tdType => 'messageAudio';


  /// The audio description 
  Audio? audio;

  /// Audio caption
  FormattedText? caption;

  MessageAudio({
    super.extra,
    super.client_id,
    this.audio,
    this.caption,
  });

  MessageAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as Audio;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// A document message (general file) 
class MessageDocument extends MessageContent {
  String get tdType => 'messageDocument';


  /// The document description 
  Document? document;

  /// Document caption
  FormattedText? caption;

  MessageDocument({
    super.extra,
    super.client_id,
    this.document,
    this.caption,
  });

  MessageDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as Document;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// A photo message 
class MessagePhoto extends MessageContent {
  String get tdType => 'messagePhoto';


  /// The photo description 
  Photo? photo;

  /// Photo caption 
  FormattedText? caption;

  /// True, if the photo must be blurred and must be shown only while tapped
  Bool? is_secret;

  MessagePhoto({
    super.extra,
    super.client_id,
    this.photo,
    this.caption,
    this.is_secret,
  });

  MessagePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// An expired photo message (self-destructed after TTL has elapsed)
class MessageExpiredPhoto extends MessageContent {
  String get tdType => 'messageExpiredPhoto';


  MessageExpiredPhoto({
    super.extra,
    super.client_id,
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

/// A sticker message 
class MessageSticker extends MessageContent {
  String get tdType => 'messageSticker';


  /// The sticker description 
  Sticker? sticker;

  /// True, if premium animation of the sticker must be played
  Bool? is_premium;

  MessageSticker({
    super.extra,
    super.client_id,
    this.sticker,
    this.is_premium,
  });

  MessageSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
    is_premium = map['is_premium'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'is_premium': is_premium?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video message 
class MessageVideo extends MessageContent {
  String get tdType => 'messageVideo';


  /// The video description 
  Video? video;

  /// Video caption 
  FormattedText? caption;

  /// True, if the video thumbnail must be blurred and the video must be shown only while tapped
  Bool? is_secret;

  MessageVideo({
    super.extra,
    super.client_id,
    this.video,
    this.caption,
    this.is_secret,
  });

  MessageVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// An expired video message (self-destructed after TTL has elapsed)
class MessageExpiredVideo extends MessageContent {
  String get tdType => 'messageExpiredVideo';


  MessageExpiredVideo({
    super.extra,
    super.client_id,
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

/// A video note message 
class MessageVideoNote extends MessageContent {
  String get tdType => 'messageVideoNote';


  /// The video note description 
  VideoNote? video_note;

  /// True, if at least one of the recipients has viewed the video note 
  Bool? is_viewed;

  /// True, if the video note thumbnail must be blurred and the video note must be shown only while tapped
  Bool? is_secret;

  MessageVideoNote({
    super.extra,
    super.client_id,
    this.video_note,
    this.is_viewed,
    this.is_secret,
  });

  MessageVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video_note'] != null) {
      video_note = TdApiMap.fromMap(map['video_note']) as VideoNote;
    }
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

/// A voice note message 
class MessageVoiceNote extends MessageContent {
  String get tdType => 'messageVoiceNote';


  /// The voice note description 
  VoiceNote? voice_note;

  /// Voice note caption 
  FormattedText? caption;

  /// True, if at least one of the recipients has listened to the voice note
  Bool? is_listened;

  MessageVoiceNote({
    super.extra,
    super.client_id,
    this.voice_note,
    this.caption,
    this.is_listened,
  });

  MessageVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
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

/// A message with a location 
class MessageLocation extends MessageContent {
  String get tdType => 'messageLocation';


  /// The location description 
  Location? location;

  /// Time relative to the message send date, for which the location can be updated, in seconds
  int32? live_period;

  /// Left time for which the location can be updated, in seconds. updateMessageContent is not sent when this field changes
  int32? expires_in;

  /// For live locations, a direction in which the location moves, in degrees; 1-360. If 0 the direction is unknown
  int32? heading;

  /// For live locations, a maximum distance to another chat member for proximity alerts, in meters (0-100000). 0 if the notification is disabled. Available only for the message sender
  int32? proximity_alert_radius;

  MessageLocation({
    super.extra,
    super.client_id,
    this.location,
    this.live_period,
    this.expires_in,
    this.heading,
    this.proximity_alert_radius,
  });

  MessageLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
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

/// A message with information about a venue 
class MessageVenue extends MessageContent {
  String get tdType => 'messageVenue';


  /// The venue description
  Venue? venue;

  MessageVenue({
    super.extra,
    super.client_id,
    this.venue,
  });

  MessageVenue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['venue'] != null) {
      venue = TdApiMap.fromMap(map['venue']) as Venue;
    }
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

/// A message with a user contact 
class MessageContact extends MessageContent {
  String get tdType => 'messageContact';


  /// The contact description
  Contact? contact;

  MessageContact({
    super.extra,
    super.client_id,
    this.contact,
  });

  MessageContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['contact'] != null) {
      contact = TdApiMap.fromMap(map['contact']) as Contact;
    }
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

/// A message with an animated emoji 
class MessageAnimatedEmoji extends MessageContent {
  String get tdType => 'messageAnimatedEmoji';


  /// The animated emoji 
  AnimatedEmoji? animated_emoji;

  /// The corresponding emoji
  string? emoji;

  MessageAnimatedEmoji({
    super.extra,
    super.client_id,
    this.animated_emoji,
    this.emoji,
  });

  MessageAnimatedEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animated_emoji'] != null) {
      animated_emoji = TdApiMap.fromMap(map['animated_emoji']) as AnimatedEmoji;
    }
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

/// A dice message. The dice value is randomly generated by the server
class MessageDice extends MessageContent {
  String get tdType => 'messageDice';


  /// The animated stickers with the initial dice animation; may be null if unknown. updateMessageContent will be sent when the sticker became known
  DiceStickers? initial_state;

  /// The animated stickers with the final dice animation; may be null if unknown. updateMessageContent will be sent when the sticker became known
  DiceStickers? final_state;

  /// Emoji on which the dice throw animation is based
  string? emoji;

  /// The dice value. If the value is 0, the dice don't have final state yet
  int32? value;

  /// Number of frame after which a success animation like a shower of confetti needs to be shown on updateMessageSendSucceeded
  int32? success_animation_frame_number;

  MessageDice({
    super.extra,
    super.client_id,
    this.initial_state,
    this.final_state,
    this.emoji,
    this.value,
    this.success_animation_frame_number,
  });

  MessageDice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['initial_state'] != null) {
      initial_state = TdApiMap.fromMap(map['initial_state']) as DiceStickers;
    }
    if (map['final_state'] != null) {
      final_state = TdApiMap.fromMap(map['final_state']) as DiceStickers;
    }
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

/// A message with a game 
class MessageGame extends MessageContent {
  String get tdType => 'messageGame';


  /// The game description
  Game? game;

  MessageGame({
    super.extra,
    super.client_id,
    this.game,
  });

  MessageGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['game'] != null) {
      game = TdApiMap.fromMap(map['game']) as Game;
    }
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

/// A message with a poll 
class MessagePoll extends MessageContent {
  String get tdType => 'messagePoll';


  /// The poll description
  Poll? poll;

  MessagePoll({
    super.extra,
    super.client_id,
    this.poll,
  });

  MessagePoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['poll'] != null) {
      poll = TdApiMap.fromMap(map['poll']) as Poll;
    }
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

/// A message with an invoice from a bot 
class MessageInvoice extends MessageContent {
  String get tdType => 'messageInvoice';


  /// Product title 
  string? title;

  FormattedText? description;

  /// Product photo; may be null 
  Photo? photo;

  /// Currency for the product price 
  string? currency;

  /// Product total price in the smallest units of the currency
  int53? total_amount;

  /// Unique invoice bot start_parameter. To share an invoice use the URL https://t.me/{bot_username}?start={start_parameter} 
  string? start_parameter;

  /// True, if the invoice is a test invoice
  Bool? is_test;

  /// True, if the shipping address must be specified 
  Bool? need_shipping_address;

  /// The identifier of the message with the receipt, after the product has been purchased
  int53? receipt_message_id;

  MessageInvoice({
    super.extra,
    super.client_id,
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
    if (map['description'] != null) {
      description = TdApiMap.fromMap(map['description']) as FormattedText;
    }
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
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

/// A message with information about an ended call 
class MessageCall extends MessageContent {
  String get tdType => 'messageCall';


  /// True, if the call was a video call 
  Bool? is_video;

  /// Reason why the call was discarded 
  CallDiscardReason? discard_reason;

  /// Call duration, in seconds
  int32? duration;

  MessageCall({
    super.extra,
    super.client_id,
    this.is_video,
    this.discard_reason,
    this.duration,
  });

  MessageCall.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    is_video = map['is_video'];
    if (map['discard_reason'] != null) {
      discard_reason = TdApiMap.fromMap(map['discard_reason']) as CallDiscardReason;
    }
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

/// A new video chat was scheduled 
class MessageVideoChatScheduled extends MessageContent {
  String get tdType => 'messageVideoChatScheduled';


  /// Identifier of the video chat. The video chat can be received through the method getGroupCall 
  int32? group_call_id;

  /// Point in time (Unix timestamp) when the group call is supposed to be started by an administrator
  int32? start_date;

  MessageVideoChatScheduled({
    super.extra,
    super.client_id,
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

/// A newly created video chat 
class MessageVideoChatStarted extends MessageContent {
  String get tdType => 'messageVideoChatStarted';


  /// Identifier of the video chat. The video chat can be received through the method getGroupCall
  int32? group_call_id;

  MessageVideoChatStarted({
    super.extra,
    super.client_id,
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

/// A message with information about an ended video chat 
class MessageVideoChatEnded extends MessageContent {
  String get tdType => 'messageVideoChatEnded';


  /// Call duration, in seconds
  int32? duration;

  MessageVideoChatEnded({
    super.extra,
    super.client_id,
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

/// A message with information about an invite to a video chat 
class MessageInviteVideoChatParticipants extends MessageContent {
  String get tdType => 'messageInviteVideoChatParticipants';


  /// Identifier of the video chat. The video chat can be received through the method getGroupCall 
  int32? group_call_id;

  /// Invited user identifiers
  vector<int53>? user_ids;

  MessageInviteVideoChatParticipants({
    super.extra,
    super.client_id,
    this.group_call_id,
    this.user_ids,
  });

  MessageInviteVideoChatParticipants.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    group_call_id = map['group_call_id'];
    if (map['user_ids'] != null) {
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

/// A newly created basic group 
class MessageBasicGroupChatCreate extends MessageContent {
  String get tdType => 'messageBasicGroupChatCreate';


  /// Title of the basic group 
  string? title;

  /// User identifiers of members in the basic group
  vector<int53>? member_user_ids;

  MessageBasicGroupChatCreate({
    super.extra,
    super.client_id,
    this.title,
    this.member_user_ids,
  });

  MessageBasicGroupChatCreate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    if (map['member_user_ids'] != null) {
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

/// A newly created supergroup or channel 
class MessageSupergroupChatCreate extends MessageContent {
  String get tdType => 'messageSupergroupChatCreate';


  /// Title of the supergroup or channel
  string? title;

  MessageSupergroupChatCreate({
    super.extra,
    super.client_id,
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

/// An updated chat title 
class MessageChatChangeTitle extends MessageContent {
  String get tdType => 'messageChatChangeTitle';


  /// New chat title
  string? title;

  MessageChatChangeTitle({
    super.extra,
    super.client_id,
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

/// An updated chat photo 
class MessageChatChangePhoto extends MessageContent {
  String get tdType => 'messageChatChangePhoto';


  /// New chat photo
  ChatPhoto? photo;

  MessageChatChangePhoto({
    super.extra,
    super.client_id,
    this.photo,
  });

  MessageChatChangePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhoto;
    }
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

/// A deleted chat photo
class MessageChatDeletePhoto extends MessageContent {
  String get tdType => 'messageChatDeletePhoto';


  MessageChatDeletePhoto({
    super.extra,
    super.client_id,
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

/// New chat members were added 
class MessageChatAddMembers extends MessageContent {
  String get tdType => 'messageChatAddMembers';


  /// User identifiers of the new members
  vector<int53>? member_user_ids;

  MessageChatAddMembers({
    super.extra,
    super.client_id,
    this.member_user_ids,
  });

  MessageChatAddMembers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['member_user_ids'] != null) {
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

/// A new member joined the chat via an invite link
class MessageChatJoinByLink extends MessageContent {
  String get tdType => 'messageChatJoinByLink';


  MessageChatJoinByLink({
    super.extra,
    super.client_id,
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

/// A new member was accepted to the chat by an administrator
class MessageChatJoinByRequest extends MessageContent {
  String get tdType => 'messageChatJoinByRequest';


  MessageChatJoinByRequest({
    super.extra,
    super.client_id,
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

/// A chat member was deleted 
class MessageChatDeleteMember extends MessageContent {
  String get tdType => 'messageChatDeleteMember';


  /// User identifier of the deleted chat member
  int53? user_id;

  MessageChatDeleteMember({
    super.extra,
    super.client_id,
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

/// A basic group was upgraded to a supergroup and was deactivated as the result 
class MessageChatUpgradeTo extends MessageContent {
  String get tdType => 'messageChatUpgradeTo';


  /// Identifier of the supergroup to which the basic group was upgraded
  int53? supergroup_id;

  MessageChatUpgradeTo({
    super.extra,
    super.client_id,
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

/// A supergroup has been created from a basic group 
class MessageChatUpgradeFrom extends MessageContent {
  String get tdType => 'messageChatUpgradeFrom';


  /// Title of the newly created supergroup 
  string? title;

  /// The identifier of the original basic group
  int53? basic_group_id;

  MessageChatUpgradeFrom({
    super.extra,
    super.client_id,
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

/// A message has been pinned 
class MessagePinMessage extends MessageContent {
  String get tdType => 'messagePinMessage';


  /// Identifier of the pinned message, can be an identifier of a deleted message or 0
  int53? message_id;

  MessagePinMessage({
    super.extra,
    super.client_id,
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

/// A screenshot of a message in the chat has been taken
class MessageScreenshotTaken extends MessageContent {
  String get tdType => 'messageScreenshotTaken';


  MessageScreenshotTaken({
    super.extra,
    super.client_id,
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

/// A theme in the chat has been changed 
class MessageChatSetTheme extends MessageContent {
  String get tdType => 'messageChatSetTheme';


  /// If non-empty, name of a new theme, set for the chat. Otherwise chat theme was reset to the default one
  string? theme_name;

  MessageChatSetTheme({
    super.extra,
    super.client_id,
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

/// The TTL (Time To Live) setting for messages in the chat has been changed 
class MessageChatSetTtl extends MessageContent {
  String get tdType => 'messageChatSetTtl';


  /// New message TTL
  int32? ttl;

  MessageChatSetTtl({
    super.extra,
    super.client_id,
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

/// A non-standard action has happened in the chat 
class MessageCustomServiceAction extends MessageContent {
  String get tdType => 'messageCustomServiceAction';


  /// Message text to be shown in the chat
  string? text;

  MessageCustomServiceAction({
    super.extra,
    super.client_id,
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

/// A new high score was achieved in a game 
class MessageGameScore extends MessageContent {
  String get tdType => 'messageGameScore';


  /// Identifier of the message with the game, can be an identifier of a deleted message 
  int53? game_message_id;

  /// Identifier of the game; may be different from the games presented in the message with the game 
  int64? game_id;

  /// New score
  int32? score;

  MessageGameScore({
    super.extra,
    super.client_id,
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

/// A payment has been completed 
class MessagePaymentSuccessful extends MessageContent {
  String get tdType => 'messagePaymentSuccessful';


  /// Identifier of the chat, containing the corresponding invoice message; 0 if unknown 
  int53? invoice_chat_id;

  /// Identifier of the message with the corresponding invoice; can be 0 or an identifier of a deleted message
  int53? invoice_message_id;

  /// Currency for the price of the product 
  string? currency;

  /// Total price for the product, in the smallest units of the currency
  int53? total_amount;

  /// True, if this is a recurring payment 
  Bool? is_recurring;

  /// True, if this is the first recurring payment 
  Bool? is_first_recurring;

  /// Name of the invoice; may be empty if unknown
  string? invoice_name;

  MessagePaymentSuccessful({
    super.extra,
    super.client_id,
    this.invoice_chat_id,
    this.invoice_message_id,
    this.currency,
    this.total_amount,
    this.is_recurring,
    this.is_first_recurring,
    this.invoice_name,
  });

  MessagePaymentSuccessful.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    invoice_chat_id = map['invoice_chat_id'];
    invoice_message_id = map['invoice_message_id'];
    currency = map['currency'];
    total_amount = map['total_amount'];
    is_recurring = map['is_recurring'];
    is_first_recurring = map['is_first_recurring'];
    invoice_name = map['invoice_name'];
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
      'is_recurring': is_recurring?.toMap(skipNulls: skipNulls),
      'is_first_recurring': is_first_recurring?.toMap(skipNulls: skipNulls),
      'invoice_name': invoice_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A payment has been completed; for bots only 
class MessagePaymentSuccessfulBot extends MessageContent {
  String get tdType => 'messagePaymentSuccessfulBot';


  /// Currency for price of the product 
  string? currency;

  /// Total price for the product, in the smallest units of the currency
  int53? total_amount;

  /// True, if this is a recurring payment 
  Bool? is_recurring;

  /// True, if this is the first recurring payment
  Bool? is_first_recurring;

  /// Invoice payload 
  bytes? invoice_payload;

  /// Identifier of the shipping option chosen by the user; may be empty if not applicable 
  string? shipping_option_id;

  /// Information about the order; may be null
  OrderInfo? order_info;

  /// Telegram payment identifier 
  string? telegram_payment_charge_id;

  /// Provider payment identifier
  string? provider_payment_charge_id;

  MessagePaymentSuccessfulBot({
    super.extra,
    super.client_id,
    this.currency,
    this.total_amount,
    this.is_recurring,
    this.is_first_recurring,
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
    is_recurring = map['is_recurring'];
    is_first_recurring = map['is_first_recurring'];
    invoice_payload = map['invoice_payload'];
    shipping_option_id = map['shipping_option_id'];
    if (map['order_info'] != null) {
      order_info = TdApiMap.fromMap(map['order_info']) as OrderInfo;
    }
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
      'is_recurring': is_recurring?.toMap(skipNulls: skipNulls),
      'is_first_recurring': is_first_recurring?.toMap(skipNulls: skipNulls),
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

/// Telegram Premium was gifted to the user 
class MessageGiftedPremium extends MessageContent {
  String get tdType => 'messageGiftedPremium';


  /// Currency for the paid amount 
  string? currency;

  /// The paid amount, in the smallest units of the currency 
  int53? amount;

  /// Number of month the Telegram Premium subscription will be active
  int32? month_count;

  /// A sticker to be shown in the message; may be null if unknown
  Sticker? sticker;

  MessageGiftedPremium({
    super.extra,
    super.client_id,
    this.currency,
    this.amount,
    this.month_count,
    this.sticker,
  });

  MessageGiftedPremium.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    currency = map['currency'];
    amount = map['amount'];
    month_count = map['month_count'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'currency': currency?.toMap(skipNulls: skipNulls),
      'amount': amount?.toMap(skipNulls: skipNulls),
      'month_count': month_count?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A contact has registered with Telegram
class MessageContactRegistered extends MessageContent {
  String get tdType => 'messageContactRegistered';


  MessageContactRegistered({
    super.extra,
    super.client_id,
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

/// The current user has connected a website by logging in using Telegram Login Widget on it 
class MessageWebsiteConnected extends MessageContent {
  String get tdType => 'messageWebsiteConnected';


  /// Domain name of the connected website
  string? domain_name;

  MessageWebsiteConnected({
    super.extra,
    super.client_id,
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

/// Data from a Web App has been sent to a bot 
class MessageWebAppDataSent extends MessageContent {
  String get tdType => 'messageWebAppDataSent';


  /// Text of the keyboardButtonTypeWebApp button, which opened the Web App
  string? button_text;

  MessageWebAppDataSent({
    super.extra,
    super.client_id,
    this.button_text,
  });

  MessageWebAppDataSent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    button_text = map['button_text'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'button_text': button_text?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Data from a Web App has been received; for bots only 
class MessageWebAppDataReceived extends MessageContent {
  String get tdType => 'messageWebAppDataReceived';


  /// Text of the keyboardButtonTypeWebApp button, which opened the Web App 
  string? button_text;

  /// Received data
  string? data;

  MessageWebAppDataReceived({
    super.extra,
    super.client_id,
    this.button_text,
    this.data,
  });

  MessageWebAppDataReceived.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    button_text = map['button_text'];
    data = map['data'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'button_text': button_text?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Telegram Passport data has been sent to a bot 
class MessagePassportDataSent extends MessageContent {
  String get tdType => 'messagePassportDataSent';


  /// List of Telegram Passport element types sent
  vector<PassportElementType>? types;

  MessagePassportDataSent({
    super.extra,
    super.client_id,
    this.types,
  });

  MessagePassportDataSent.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['types'] != null) {
      types = [];
      for (var someValue in map['types']) {
        if (someValue != null) {
          types?.add(TdApiMap.fromMap(someValue) as PassportElementType);
        }
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

/// Telegram Passport data has been received; for bots only 
class MessagePassportDataReceived extends MessageContent {
  String get tdType => 'messagePassportDataReceived';


  /// List of received Telegram Passport elements 
  vector<EncryptedPassportElement>? elements;

  /// Encrypted data credentials
  EncryptedCredentials? credentials;

  MessagePassportDataReceived({
    super.extra,
    super.client_id,
    this.elements,
    this.credentials,
  });

  MessagePassportDataReceived.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['elements'] != null) {
      elements = [];
      for (var someValue in map['elements']) {
        if (someValue != null) {
          elements?.add(TdApiMap.fromMap(someValue) as EncryptedPassportElement);
        }
      }
    }
    if (map['credentials'] != null) {
      credentials = TdApiMap.fromMap(map['credentials']) as EncryptedCredentials;
    }
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

/// A user in the chat came within proximity alert range 
class MessageProximityAlertTriggered extends MessageContent {
  String get tdType => 'messageProximityAlertTriggered';


  /// The identifier of a user or chat that triggered the proximity alert 
  MessageSender? traveler_id;

  /// The identifier of a user or chat that subscribed for the proximity alert 
  MessageSender? watcher_id;

  /// The distance between the users
  int32? distance;

  MessageProximityAlertTriggered({
    super.extra,
    super.client_id,
    this.traveler_id,
    this.watcher_id,
    this.distance,
  });

  MessageProximityAlertTriggered.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['traveler_id'] != null) {
      traveler_id = TdApiMap.fromMap(map['traveler_id']) as MessageSender;
    }
    if (map['watcher_id'] != null) {
      watcher_id = TdApiMap.fromMap(map['watcher_id']) as MessageSender;
    }
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

/// Message content that is not supported in the current TDLib version
class MessageUnsupported extends MessageContent {
  String get tdType => 'messageUnsupported';


  MessageUnsupported({
    super.extra,
    super.client_id,
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
