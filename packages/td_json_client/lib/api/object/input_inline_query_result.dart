import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/input_message_content.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';

abstract class InputInlineQueryResult extends TdObject {}

class InputInlineQueryResultAnimation extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultAnimation';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? thumbnail_url;
  string? thumbnail_mime_type;
  string? video_url;
  string? video_mime_type;
  int32? video_duration;
  int32? video_width;
  int32? video_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultAnimation({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.thumbnail_url,
    this.thumbnail_mime_type,
    this.video_url,
    this.video_mime_type,
    this.video_duration,
    this.video_width,
    this.video_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    thumbnail_url = map['thumbnail_url'];
    thumbnail_mime_type = map['thumbnail_mime_type'];
    video_url = map['video_url'];
    video_mime_type = map['video_mime_type'];
    video_duration = map['video_duration'];
    video_width = map['video_width'];
    video_height = map['video_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_mime_type': thumbnail_mime_type?.toMap(skipNulls: skipNulls),
      'video_url': video_url?.toMap(skipNulls: skipNulls),
      'video_mime_type': video_mime_type?.toMap(skipNulls: skipNulls),
      'video_duration': video_duration?.toMap(skipNulls: skipNulls),
      'video_width': video_width?.toMap(skipNulls: skipNulls),
      'video_height': video_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultArticle extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultArticle';

  String? extra;
  int? client_id;
  string? id;
  string? url;
  Bool? hide_url;
  string? title;
  string? description;
  string? thumbnail_url;
  int32? thumbnail_width;
  int32? thumbnail_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultArticle({
    this.extra,
    this.client_id,
    this.id,
    this.url,
    this.hide_url,
    this.title,
    this.description,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultArticle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    url = map['url'];
    hide_url = map['hide_url'];
    title = map['title'];
    description = map['description'];
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'hide_url': hide_url?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_width': thumbnail_width?.toMap(skipNulls: skipNulls),
      'thumbnail_height': thumbnail_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultAudio extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultAudio';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? performer;
  string? audio_url;
  int32? audio_duration;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultAudio({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.performer,
    this.audio_url,
    this.audio_duration,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    performer = map['performer'];
    audio_url = map['audio_url'];
    audio_duration = map['audio_duration'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'performer': performer?.toMap(skipNulls: skipNulls),
      'audio_url': audio_url?.toMap(skipNulls: skipNulls),
      'audio_duration': audio_duration?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultContact extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultContact';

  String? extra;
  int? client_id;
  string? id;
  Contact? contact;
  string? thumbnail_url;
  int32? thumbnail_width;
  int32? thumbnail_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultContact({
    this.extra,
    this.client_id,
    this.id,
    this.contact,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    contact = TdApiMap.fromMap(map['contact']) as Contact;
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'contact': contact?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_width': thumbnail_width?.toMap(skipNulls: skipNulls),
      'thumbnail_height': thumbnail_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultDocument extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultDocument';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? description;
  string? document_url;
  string? mime_type;
  string? thumbnail_url;
  int32? thumbnail_width;
  int32? thumbnail_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultDocument({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.description,
    this.document_url,
    this.mime_type,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    description = map['description'];
    document_url = map['document_url'];
    mime_type = map['mime_type'];
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'document_url': document_url?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_width': thumbnail_width?.toMap(skipNulls: skipNulls),
      'thumbnail_height': thumbnail_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultGame extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultGame';

  String? extra;
  int? client_id;
  string? id;
  string? game_short_name;
  ReplyMarkup? reply_markup;

  InputInlineQueryResultGame({
    this.extra,
    this.client_id,
    this.id,
    this.game_short_name,
    this.reply_markup,
  });

  InputInlineQueryResultGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    game_short_name = map['game_short_name'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'game_short_name': game_short_name?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultLocation extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultLocation';

  String? extra;
  int? client_id;
  string? id;
  Location? location;
  int32? live_period;
  string? title;
  string? thumbnail_url;
  int32? thumbnail_width;
  int32? thumbnail_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultLocation({
    this.extra,
    this.client_id,
    this.id,
    this.location,
    this.live_period,
    this.title,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    location = TdApiMap.fromMap(map['location']) as Location;
    live_period = map['live_period'];
    title = map['title'];
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'live_period': live_period?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_width': thumbnail_width?.toMap(skipNulls: skipNulls),
      'thumbnail_height': thumbnail_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultPhoto extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultPhoto';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? description;
  string? thumbnail_url;
  string? photo_url;
  int32? photo_width;
  int32? photo_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultPhoto({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.description,
    this.thumbnail_url,
    this.photo_url,
    this.photo_width,
    this.photo_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    description = map['description'];
    thumbnail_url = map['thumbnail_url'];
    photo_url = map['photo_url'];
    photo_width = map['photo_width'];
    photo_height = map['photo_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'photo_url': photo_url?.toMap(skipNulls: skipNulls),
      'photo_width': photo_width?.toMap(skipNulls: skipNulls),
      'photo_height': photo_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultSticker extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultSticker';

  String? extra;
  int? client_id;
  string? id;
  string? thumbnail_url;
  string? sticker_url;
  int32? sticker_width;
  int32? sticker_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultSticker({
    this.extra,
    this.client_id,
    this.id,
    this.thumbnail_url,
    this.sticker_url,
    this.sticker_width,
    this.sticker_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    thumbnail_url = map['thumbnail_url'];
    sticker_url = map['sticker_url'];
    sticker_width = map['sticker_width'];
    sticker_height = map['sticker_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'sticker_url': sticker_url?.toMap(skipNulls: skipNulls),
      'sticker_width': sticker_width?.toMap(skipNulls: skipNulls),
      'sticker_height': sticker_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultVenue extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVenue';

  String? extra;
  int? client_id;
  string? id;
  Venue? venue;
  string? thumbnail_url;
  int32? thumbnail_width;
  int32? thumbnail_height;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultVenue({
    this.extra,
    this.client_id,
    this.id,
    this.venue,
    this.thumbnail_url,
    this.thumbnail_width,
    this.thumbnail_height,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultVenue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    venue = TdApiMap.fromMap(map['venue']) as Venue;
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'venue': venue?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'thumbnail_width': thumbnail_width?.toMap(skipNulls: skipNulls),
      'thumbnail_height': thumbnail_height?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultVideo extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVideo';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? description;
  string? thumbnail_url;
  string? video_url;
  string? mime_type;
  int32? video_width;
  int32? video_height;
  int32? video_duration;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultVideo({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.description,
    this.thumbnail_url,
    this.video_url,
    this.mime_type,
    this.video_width,
    this.video_height,
    this.video_duration,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    description = map['description'];
    thumbnail_url = map['thumbnail_url'];
    video_url = map['video_url'];
    mime_type = map['mime_type'];
    video_width = map['video_width'];
    video_height = map['video_height'];
    video_duration = map['video_duration'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
      'thumbnail_url': thumbnail_url?.toMap(skipNulls: skipNulls),
      'video_url': video_url?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'video_width': video_width?.toMap(skipNulls: skipNulls),
      'video_height': video_height?.toMap(skipNulls: skipNulls),
      'video_duration': video_duration?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
class InputInlineQueryResultVoiceNote extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVoiceNote';

  String? extra;
  int? client_id;
  string? id;
  string? title;
  string? voice_note_url;
  int32? voice_note_duration;
  ReplyMarkup? reply_markup;
  InputMessageContent? input_message_content;

  InputInlineQueryResultVoiceNote({
    this.extra,
    this.client_id,
    this.id,
    this.title,
    this.voice_note_url,
    this.voice_note_duration,
    this.reply_markup,
    this.input_message_content,
  });

  InputInlineQueryResultVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
    voice_note_url = map['voice_note_url'];
    voice_note_duration = map['voice_note_duration'];
    reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'voice_note_url': voice_note_url?.toMap(skipNulls: skipNulls),
      'voice_note_duration': voice_note_duration?.toMap(skipNulls: skipNulls),
      'reply_markup': reply_markup?.toMap(skipNulls: skipNulls),
      'input_message_content': input_message_content?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
