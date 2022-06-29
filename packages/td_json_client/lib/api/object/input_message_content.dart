import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';
import 'package:td_json_client/api/object/input_file.dart';
import 'package:td_json_client/api/object/input_thumbnail.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/invoice.dart';
import 'package:td_json_client/api/object/poll_type.dart';
import 'package:td_json_client/api/object/message_copy_options.dart';

/// The content of a message to send
abstract class InputMessageContent extends TdObject {}


/// A text message 
class InputMessageText extends InputMessageContent {
  String get tdType => 'inputMessageText';

  String? extra;
  int? client_id;

  /// Formatted text to be sent; 1-GetOption("message_text_length_max") characters. Only Bold, Italic, Underline, Strikethrough, Code, Pre, PreCode, TextUrl and MentionName entities are allowed to be specified manually
  FormattedText? text;

  /// True, if rich web page previews for URLs in the message text must be disabled 
  Bool? disable_web_page_preview;

  /// True, if a chat message draft must be deleted
  Bool? clear_draft;

  InputMessageText({
    this.extra,
    this.client_id,
    this.text,
    this.disable_web_page_preview,
    this.clear_draft,
  });

  InputMessageText.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as FormattedText;
    }
    disable_web_page_preview = map['disable_web_page_preview'];
    clear_draft = map['clear_draft'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'disable_web_page_preview': disable_web_page_preview?.toMap(skipNulls: skipNulls),
      'clear_draft': clear_draft?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An animation message (GIF-style). 
class InputMessageAnimation extends InputMessageContent {
  String get tdType => 'inputMessageAnimation';

  String? extra;
  int? client_id;

  /// Animation file to be sent 
  InputFile? animation;

  /// Animation thumbnail; pass null to skip thumbnail uploading 
  InputThumbnail? thumbnail;

  /// File identifiers of the stickers added to the animation, if applicable
  vector<int32>? added_sticker_file_ids;

  /// Duration of the animation, in seconds 
  int32? duration;

  /// Width of the animation; may be replaced by the server 
  int32? width;

  /// Height of the animation; may be replaced by the server 
  int32? height;

  /// Animation caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters
  FormattedText? caption;

  InputMessageAnimation({
    this.extra,
    this.client_id,
    this.animation,
    this.thumbnail,
    this.added_sticker_file_ids,
    this.duration,
    this.width,
    this.height,
    this.caption,
  });

  InputMessageAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    if (map['added_sticker_file_ids'] != null) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'added_sticker_file_ids': added_sticker_file_ids?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An audio message 
class InputMessageAudio extends InputMessageContent {
  String get tdType => 'inputMessageAudio';

  String? extra;
  int? client_id;

  /// Audio file to be sent 
  InputFile? audio;

  /// Thumbnail of the cover for the album; pass null to skip thumbnail uploading 
  InputThumbnail? album_cover_thumbnail;

  /// Duration of the audio, in seconds; may be replaced by the server 
  int32? duration;

  /// Title of the audio; 0-64 characters; may be replaced by the server
  string? title;

  /// Performer of the audio; 0-64 characters, may be replaced by the server 
  string? performer;

  /// Audio caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters
  FormattedText? caption;

  InputMessageAudio({
    this.extra,
    this.client_id,
    this.audio,
    this.album_cover_thumbnail,
    this.duration,
    this.title,
    this.performer,
    this.caption,
  });

  InputMessageAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as InputFile;
    }
    if (map['album_cover_thumbnail'] != null) {
      album_cover_thumbnail = TdApiMap.fromMap(map['album_cover_thumbnail']) as InputThumbnail;
    }
    duration = map['duration'];
    title = map['title'];
    performer = map['performer'];
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
      'album_cover_thumbnail': album_cover_thumbnail?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'performer': performer?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A document message (general file) 
class InputMessageDocument extends InputMessageContent {
  String get tdType => 'inputMessageDocument';

  String? extra;
  int? client_id;

  /// Document to be sent 
  InputFile? document;

  /// Document thumbnail; pass null to skip thumbnail uploading 
  InputThumbnail? thumbnail;

  /// If true, automatic file type detection will be disabled and the document will be always sent as file. Always true for files sent to secret chats 
  Bool? disable_content_type_detection;

  /// Document caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters
  FormattedText? caption;

  InputMessageDocument({
    this.extra,
    this.client_id,
    this.document,
    this.thumbnail,
    this.disable_content_type_detection,
    this.caption,
  });

  InputMessageDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    disable_content_type_detection = map['disable_content_type_detection'];
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
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'disable_content_type_detection': disable_content_type_detection?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A photo message 
class InputMessagePhoto extends InputMessageContent {
  String get tdType => 'inputMessagePhoto';

  String? extra;
  int? client_id;

  /// Photo to send 
  InputFile? photo;

  /// Photo thumbnail to be sent; pass null to skip thumbnail uploading. The thumbnail is sent to the other party only in secret chats 
  InputThumbnail? thumbnail;

  /// File identifiers of the stickers added to the photo, if applicable 
  vector<int32>? added_sticker_file_ids;

  /// Photo width 
  int32? width;

  /// Photo height 
  int32? height;

  /// Photo caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters
  FormattedText? caption;

  /// Photo TTL (Time To Live), in seconds (0-60). A non-zero TTL can be specified only in private chats
  int32? ttl;

  InputMessagePhoto({
    this.extra,
    this.client_id,
    this.photo,
    this.thumbnail,
    this.added_sticker_file_ids,
    this.width,
    this.height,
    this.caption,
    this.ttl,
  });

  InputMessagePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    if (map['added_sticker_file_ids'] != null) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    width = map['width'];
    height = map['height'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
    ttl = map['ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'added_sticker_file_ids': added_sticker_file_ids?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A sticker message 
class InputMessageSticker extends InputMessageContent {
  String get tdType => 'inputMessageSticker';

  String? extra;
  int? client_id;

  /// Sticker to be sent 
  InputFile? sticker;

  /// Sticker thumbnail; pass null to skip thumbnail uploading 
  InputThumbnail? thumbnail;

  /// Sticker width 
  int32? width;

  /// Sticker height 
  int32? height;

  /// Emoji used to choose the sticker
  string? emoji;

  InputMessageSticker({
    this.extra,
    this.client_id,
    this.sticker,
    this.thumbnail,
    this.width,
    this.height,
    this.emoji,
  });

  InputMessageSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    width = map['width'];
    height = map['height'];
    emoji = map['emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video message 
class InputMessageVideo extends InputMessageContent {
  String get tdType => 'inputMessageVideo';

  String? extra;
  int? client_id;

  /// Video to be sent 
  InputFile? video;

  /// Video thumbnail; pass null to skip thumbnail uploading 
  InputThumbnail? thumbnail;

  /// File identifiers of the stickers added to the video, if applicable
  vector<int32>? added_sticker_file_ids;

  /// Duration of the video, in seconds 
  int32? duration;

  /// Video width 
  int32? width;

  /// Video height 
  int32? height;

  /// True, if the video is supposed to be streamed
  Bool? supports_streaming;

  /// Video caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters 
  FormattedText? caption;

  /// Video TTL (Time To Live), in seconds (0-60). A non-zero TTL can be specified only in private chats
  int32? ttl;

  InputMessageVideo({
    this.extra,
    this.client_id,
    this.video,
    this.thumbnail,
    this.added_sticker_file_ids,
    this.duration,
    this.width,
    this.height,
    this.supports_streaming,
    this.caption,
    this.ttl,
  });

  InputMessageVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    if (map['added_sticker_file_ids'] != null) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    supports_streaming = map['supports_streaming'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
    ttl = map['ttl'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'added_sticker_file_ids': added_sticker_file_ids?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'supports_streaming': supports_streaming?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'ttl': ttl?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video note message 
class InputMessageVideoNote extends InputMessageContent {
  String get tdType => 'inputMessageVideoNote';

  String? extra;
  int? client_id;

  /// Video note to be sent 
  InputFile? video_note;

  /// Video thumbnail; pass null to skip thumbnail uploading 
  InputThumbnail? thumbnail;

  /// Duration of the video, in seconds 
  int32? duration;

  /// Video width and height; must be positive and not greater than 640
  int32? length;

  InputMessageVideoNote({
    this.extra,
    this.client_id,
    this.video_note,
    this.thumbnail,
    this.duration,
    this.length,
  });

  InputMessageVideoNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video_note'] != null) {
      video_note = TdApiMap.fromMap(map['video_note']) as InputFile;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    }
    duration = map['duration'];
    length = map['length'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video_note': video_note?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'length': length?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A voice note message 
class InputMessageVoiceNote extends InputMessageContent {
  String get tdType => 'inputMessageVoiceNote';

  String? extra;
  int? client_id;

  /// Voice note to be sent 
  InputFile? voice_note;

  /// Duration of the voice note, in seconds 
  int32? duration;

  /// Waveform representation of the voice note, in 5-bit format 
  bytes? waveform;

  /// Voice note caption; pass null to use an empty caption; 0-GetOption("message_caption_length_max") characters
  FormattedText? caption;

  InputMessageVoiceNote({
    this.extra,
    this.client_id,
    this.voice_note,
    this.duration,
    this.waveform,
    this.caption,
  });

  InputMessageVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as InputFile;
    }
    duration = map['duration'];
    waveform = map['waveform'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'duration': duration?.toMap(skipNulls: skipNulls),
      'waveform': waveform?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a location 
class InputMessageLocation extends InputMessageContent {
  String get tdType => 'inputMessageLocation';

  String? extra;
  int? client_id;

  /// Location to be sent 
  Location? location;

  /// Period for which the location can be updated, in seconds; must be between 60 and 86400 for a live location and 0 otherwise
  int32? live_period;

  /// For live locations, a direction in which the location moves, in degrees; 1-360. Pass 0 if unknown
  int32? heading;

  /// For live locations, a maximum distance to another chat member for proximity alerts, in meters (0-100000). Pass 0 if the notification is disabled. Can't be enabled in channels and Saved Messages
  int32? proximity_alert_radius;

  InputMessageLocation({
    this.extra,
    this.client_id,
    this.location,
    this.live_period,
    this.heading,
    this.proximity_alert_radius,
  });

  InputMessageLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
    live_period = map['live_period'];
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
class InputMessageVenue extends InputMessageContent {
  String get tdType => 'inputMessageVenue';

  String? extra;
  int? client_id;

  /// Venue to send
  Venue? venue;

  InputMessageVenue({
    this.extra,
    this.client_id,
    this.venue,
  });

  InputMessageVenue.fromMap(Map<String, dynamic> map) {
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

/// A message containing a user contact 
class InputMessageContact extends InputMessageContent {
  String get tdType => 'inputMessageContact';

  String? extra;
  int? client_id;

  /// Contact to send
  Contact? contact;

  InputMessageContact({
    this.extra,
    this.client_id,
    this.contact,
  });

  InputMessageContact.fromMap(Map<String, dynamic> map) {
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

/// A dice message 
class InputMessageDice extends InputMessageContent {
  String get tdType => 'inputMessageDice';

  String? extra;
  int? client_id;

  /// Emoji on which the dice throw animation is based 
  string? emoji;

  /// True, if the chat message draft must be deleted
  Bool? clear_draft;

  InputMessageDice({
    this.extra,
    this.client_id,
    this.emoji,
    this.clear_draft,
  });

  InputMessageDice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
    clear_draft = map['clear_draft'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
      'clear_draft': clear_draft?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a game; not supported for channels or secret chats 
class InputMessageGame extends InputMessageContent {
  String get tdType => 'inputMessageGame';

  String? extra;
  int? client_id;

  /// User identifier of the bot that owns the game 
  int53? bot_user_id;

  /// Short name of the game
  string? game_short_name;

  InputMessageGame({
    this.extra,
    this.client_id,
    this.bot_user_id,
    this.game_short_name,
  });

  InputMessageGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bot_user_id = map['bot_user_id'];
    game_short_name = map['game_short_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bot_user_id': bot_user_id?.toMap(skipNulls: skipNulls),
      'game_short_name': game_short_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with an invoice; can be used only by bots 
class InputMessageInvoice extends InputMessageContent {
  String get tdType => 'inputMessageInvoice';

  String? extra;
  int? client_id;

  /// Invoice 
  Invoice? invoice;

  /// Product title; 1-32 characters 
  string? title;

  string? description;

  /// Product photo URL; optional 
  string? photo_url;

  /// Product photo size 
  int32? photo_size;

  /// Product photo width 
  int32? photo_width;

  /// Product photo height
  int32? photo_height;

  /// The invoice payload 
  bytes? payload;

  /// Payment provider token 
  string? provider_token;

  /// JSON-encoded data about the invoice, which will be shared with the payment provider
  string? provider_data;

  /// Unique invoice bot deep link parameter for the generation of this invoice. If empty, it would be possible to pay directly from forwards of the invoice message
  string? start_parameter;

  InputMessageInvoice({
    this.extra,
    this.client_id,
    this.invoice,
    this.title,
    this.description,
    this.photo_url,
    this.photo_size,
    this.photo_width,
    this.photo_height,
    this.payload,
    this.provider_token,
    this.provider_data,
    this.start_parameter,
  });

  InputMessageInvoice.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['invoice'] != null) {
      invoice = TdApiMap.fromMap(map['invoice']) as Invoice;
    }
    title = map['title'];
    description = map['description'];
    photo_url = map['photo_url'];
    photo_size = map['photo_size'];
    photo_width = map['photo_width'];
    photo_height = map['photo_height'];
    payload = map['payload'];
    provider_token = map['provider_token'];
    provider_data = map['provider_data'];
    start_parameter = map['start_parameter'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'invoice': invoice?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'photo_url': photo_url?.toMap(skipNulls: skipNulls),
      'photo_size': photo_size?.toMap(skipNulls: skipNulls),
      'photo_width': photo_width?.toMap(skipNulls: skipNulls),
      'photo_height': photo_height?.toMap(skipNulls: skipNulls),
      'payload': payload?.toMap(skipNulls: skipNulls),
      'provider_token': provider_token?.toMap(skipNulls: skipNulls),
      'provider_data': provider_data?.toMap(skipNulls: skipNulls),
      'start_parameter': start_parameter?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A message with a poll. Polls can't be sent to secret chats. Polls can be sent only to a private chat with a bot 
class InputMessagePoll extends InputMessageContent {
  String get tdType => 'inputMessagePoll';

  String? extra;
  int? client_id;

  /// Poll question; 1-255 characters (up to 300 characters for bots) 
  string? question;

  /// List of poll answer options, 2-10 strings 1-100 characters each
  vector<string>? options;

  /// True, if the poll voters are anonymous. Non-anonymous polls can't be sent or forwarded to channels 
  Bool? is_anonymous;

  /// Type of the poll
  PollType? type;

  /// Amount of time the poll will be active after creation, in seconds; for bots only
  int32? open_period;

  /// Point in time (Unix timestamp) when the poll will automatically be closed; for bots only
  int32? close_date;

  /// True, if the poll needs to be sent already closed; for bots only
  Bool? is_closed;

  InputMessagePoll({
    this.extra,
    this.client_id,
    this.question,
    this.options,
    this.is_anonymous,
    this.type,
    this.open_period,
    this.close_date,
    this.is_closed,
  });

  InputMessagePoll.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    question = map['question'];
    if (map['options'] != null) {
      options = [];
      for (var someValue in map['options']) {
        options?.add(someValue);
      }
    }
    is_anonymous = map['is_anonymous'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PollType;
    }
    open_period = map['open_period'];
    close_date = map['close_date'];
    is_closed = map['is_closed'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'question': question?.toMap(skipNulls: skipNulls),
      'options': options?.toMap(skipNulls: skipNulls),
      'is_anonymous': is_anonymous?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'open_period': open_period?.toMap(skipNulls: skipNulls),
      'close_date': close_date?.toMap(skipNulls: skipNulls),
      'is_closed': is_closed?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A forwarded message 
class InputMessageForwarded extends InputMessageContent {
  String get tdType => 'inputMessageForwarded';

  String? extra;
  int? client_id;

  /// Identifier for the chat this forwarded message came from 
  int53? from_chat_id;

  /// Identifier of the message to forward
  int53? message_id;

  /// True, if a game message is being shared from a launched game; applies only to game messages
  Bool? in_game_share;

  /// Options to be used to copy content of the message without reference to the original sender; pass null to forward the message as usual
  MessageCopyOptions? copy_options;

  InputMessageForwarded({
    this.extra,
    this.client_id,
    this.from_chat_id,
    this.message_id,
    this.in_game_share,
    this.copy_options,
  });

  InputMessageForwarded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    from_chat_id = map['from_chat_id'];
    message_id = map['message_id'];
    in_game_share = map['in_game_share'];
    if (map['copy_options'] != null) {
      copy_options = TdApiMap.fromMap(map['copy_options']) as MessageCopyOptions;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'from_chat_id': from_chat_id?.toMap(skipNulls: skipNulls),
      'message_id': message_id?.toMap(skipNulls: skipNulls),
      'in_game_share': in_game_share?.toMap(skipNulls: skipNulls),
      'copy_options': copy_options?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
