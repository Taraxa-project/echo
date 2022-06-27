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

abstract class InputMessageContent extends TdObject {}

class InputMessageText extends InputMessageContent {
  String get tdType => 'inputMessageText';

  string? extra;
  int? client_id;
  FormattedText? text;
  Bool? disable_web_page_preview;
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
    text = TdApiMap.fromMap(map['text']) as FormattedText;
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
class InputMessageAnimation extends InputMessageContent {
  String get tdType => 'inputMessageAnimation';

  string? extra;
  int? client_id;
  InputFile? animation;
  InputThumbnail? thumbnail;
  vector<int32>? added_sticker_file_ids;
  int32? duration;
  int32? width;
  int32? height;
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
    animation = TdApiMap.fromMap(map['animation']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    if (map['added_sticker_file_ids']) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessageAudio extends InputMessageContent {
  String get tdType => 'inputMessageAudio';

  string? extra;
  int? client_id;
  InputFile? audio;
  InputThumbnail? album_cover_thumbnail;
  int32? duration;
  string? title;
  string? performer;
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
    audio = TdApiMap.fromMap(map['audio']) as InputFile;
    album_cover_thumbnail = TdApiMap.fromMap(map['album_cover_thumbnail']) as InputThumbnail;
    duration = map['duration'];
    title = map['title'];
    performer = map['performer'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessageDocument extends InputMessageContent {
  String get tdType => 'inputMessageDocument';

  string? extra;
  int? client_id;
  InputFile? document;
  InputThumbnail? thumbnail;
  Bool? disable_content_type_detection;
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
    document = TdApiMap.fromMap(map['document']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    disable_content_type_detection = map['disable_content_type_detection'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessagePhoto extends InputMessageContent {
  String get tdType => 'inputMessagePhoto';

  string? extra;
  int? client_id;
  InputFile? photo;
  InputThumbnail? thumbnail;
  vector<int32>? added_sticker_file_ids;
  int32? width;
  int32? height;
  FormattedText? caption;
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
    photo = TdApiMap.fromMap(map['photo']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    if (map['added_sticker_file_ids']) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    width = map['width'];
    height = map['height'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessageSticker extends InputMessageContent {
  String get tdType => 'inputMessageSticker';

  string? extra;
  int? client_id;
  InputFile? sticker;
  InputThumbnail? thumbnail;
  int32? width;
  int32? height;
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
    sticker = TdApiMap.fromMap(map['sticker']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
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
class InputMessageVideo extends InputMessageContent {
  String get tdType => 'inputMessageVideo';

  string? extra;
  int? client_id;
  InputFile? video;
  InputThumbnail? thumbnail;
  vector<int32>? added_sticker_file_ids;
  int32? duration;
  int32? width;
  int32? height;
  Bool? supports_streaming;
  FormattedText? caption;
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
    video = TdApiMap.fromMap(map['video']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
    if (map['added_sticker_file_ids']) {
      added_sticker_file_ids = [];
      for (var someValue in map['added_sticker_file_ids']) {
        added_sticker_file_ids?.add(someValue);
      }
    }
    duration = map['duration'];
    width = map['width'];
    height = map['height'];
    supports_streaming = map['supports_streaming'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessageVideoNote extends InputMessageContent {
  String get tdType => 'inputMessageVideoNote';

  string? extra;
  int? client_id;
  InputFile? video_note;
  InputThumbnail? thumbnail;
  int32? duration;
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
    video_note = TdApiMap.fromMap(map['video_note']) as InputFile;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as InputThumbnail;
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
class InputMessageVoiceNote extends InputMessageContent {
  String get tdType => 'inputMessageVoiceNote';

  string? extra;
  int? client_id;
  InputFile? voice_note;
  int32? duration;
  bytes? waveform;
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
    voice_note = TdApiMap.fromMap(map['voice_note']) as InputFile;
    duration = map['duration'];
    waveform = map['waveform'];
    caption = TdApiMap.fromMap(map['caption']) as FormattedText;
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
class InputMessageLocation extends InputMessageContent {
  String get tdType => 'inputMessageLocation';

  string? extra;
  int? client_id;
  Location? location;
  int32? live_period;
  int32? heading;
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
    location = TdApiMap.fromMap(map['location']) as Location;
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
class InputMessageVenue extends InputMessageContent {
  String get tdType => 'inputMessageVenue';

  string? extra;
  int? client_id;
  Venue? venue;

  InputMessageVenue({
    this.extra,
    this.client_id,
    this.venue,
  });

  InputMessageVenue.fromMap(Map<String, dynamic> map) {
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
class InputMessageContact extends InputMessageContent {
  String get tdType => 'inputMessageContact';

  string? extra;
  int? client_id;
  Contact? contact;

  InputMessageContact({
    this.extra,
    this.client_id,
    this.contact,
  });

  InputMessageContact.fromMap(Map<String, dynamic> map) {
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
class InputMessageDice extends InputMessageContent {
  String get tdType => 'inputMessageDice';

  string? extra;
  int? client_id;
  string? emoji;
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
class InputMessageGame extends InputMessageContent {
  String get tdType => 'inputMessageGame';

  string? extra;
  int? client_id;
  int53? bot_user_id;
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
class InputMessageInvoice extends InputMessageContent {
  String get tdType => 'inputMessageInvoice';

  string? extra;
  int? client_id;
  Invoice? invoice;
  string? title;
  string? description;
  string? photo_url;
  int32? photo_size;
  int32? photo_width;
  int32? photo_height;
  bytes? payload;
  string? provider_token;
  string? provider_data;
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
    invoice = TdApiMap.fromMap(map['invoice']) as Invoice;
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
class InputMessagePoll extends InputMessageContent {
  String get tdType => 'inputMessagePoll';

  string? extra;
  int? client_id;
  string? question;
  vector<string>? options;
  Bool? is_anonymous;
  PollType? type;
  int32? open_period;
  int32? close_date;
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
    if (map['options']) {
      options = [];
      for (var someValue in map['options']) {
        options?.add(someValue);
      }
    }
    is_anonymous = map['is_anonymous'];
    type = TdApiMap.fromMap(map['type']) as PollType;
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
class InputMessageForwarded extends InputMessageContent {
  String get tdType => 'inputMessageForwarded';

  string? extra;
  int? client_id;
  int53? from_chat_id;
  int53? message_id;
  Bool? in_game_share;
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
    copy_options = TdApiMap.fromMap(map['copy_options']) as MessageCopyOptions;
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
