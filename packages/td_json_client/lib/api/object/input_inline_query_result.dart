import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/reply_markup.dart';
import 'package:td_json_client/api/object/input_message_content.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';

/// Represents a single result of an inline query; for bots only
abstract class InputInlineQueryResult extends TdObject {}


/// Represents a link to an animated GIF or an animated (i.e., without sound) H.264/MPEG-4 AVC video
class InputInlineQueryResultAnimation extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultAnimation';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the query result
  string? title;

  /// URL of the result thumbnail (JPEG, GIF, or MPEG4), if it exists 
  string? thumbnail_url;

  /// MIME type of the video thumbnail. If non-empty, must be one of "image/jpeg", "image/gif" and "video/mp4"
  string? thumbnail_mime_type;

  /// The URL of the video file (file size must not exceed 1MB) 
  string? video_url;

  /// MIME type of the video file. Must be one of "image/gif" and "video/mp4"
  string? video_mime_type;

  /// Duration of the video, in seconds 
  int32? video_duration;

  /// Width of the video 
  int32? video_width;

  /// Height of the video
  int32? video_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageAnimation, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to an article or web page 
class InputInlineQueryResultArticle extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultArticle';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// URL of the result, if it exists 
  string? url;

  /// True, if the URL must be not shown 
  Bool? hide_url;

  /// Title of the result
  string? title;

  string? description;

  /// URL of the result thumbnail, if it exists 
  string? thumbnail_url;

  /// Thumbnail width, if known 
  int32? thumbnail_width;

  /// Thumbnail height, if known
  int32? thumbnail_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to an MP3 audio file 
class InputInlineQueryResultAudio extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultAudio';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the audio file 
  string? title;

  /// Performer of the audio file
  string? performer;

  /// The URL of the audio file 
  string? audio_url;

  /// Audio file duration, in seconds
  int32? audio_duration;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageAudio, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a user contact 
class InputInlineQueryResultContact extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultContact';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// User contact 
  Contact? contact;

  /// URL of the result thumbnail, if it exists 
  string? thumbnail_url;

  /// Thumbnail width, if known 
  int32? thumbnail_width;

  /// Thumbnail height, if known
  int32? thumbnail_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['contact'] != null) {
      contact = TdApiMap.fromMap(map['contact']) as Contact;
    }
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to a file 
class InputInlineQueryResultDocument extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultDocument';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the resulting file 
  string? title;

  string? description;

  /// URL of the file 
  string? document_url;

  /// MIME type of the file content; only "application/pdf" and "application/zip" are currently allowed
  string? mime_type;

  /// The URL of the file thumbnail, if it exists 
  string? thumbnail_url;

  /// Width of the thumbnail 
  int32? thumbnail_width;

  /// Height of the thumbnail
  int32? thumbnail_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageDocument, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a game 
class InputInlineQueryResultGame extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultGame';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Short name of the game 
  string? game_short_name;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
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

/// Represents a point on the map 
class InputInlineQueryResultLocation extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultLocation';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Location result
  Location? location;

  /// Amount of time relative to the message sent time until the location can be updated, in seconds
  int32? live_period;

  /// Title of the result 
  string? title;

  /// URL of the result thumbnail, if it exists 
  string? thumbnail_url;

  /// Thumbnail width, if known 
  int32? thumbnail_width;

  /// Thumbnail height, if known
  int32? thumbnail_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
    live_period = map['live_period'];
    title = map['title'];
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents link to a JPEG image 
class InputInlineQueryResultPhoto extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultPhoto';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the result, if known 
  string? title;

  string? description;

  /// URL of the photo thumbnail, if it exists
  string? thumbnail_url;

  /// The URL of the JPEG photo (photo size must not exceed 5MB) 
  string? photo_url;

  /// Width of the photo 
  int32? photo_width;

  /// Height of the photo
  int32? photo_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessagePhoto, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to a WEBP, TGS, or WEBM sticker 
class InputInlineQueryResultSticker extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultSticker';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// URL of the sticker thumbnail, if it exists
  string? thumbnail_url;

  /// The URL of the WEBP, TGS, or WEBM sticker (sticker file size must not exceed 5MB) 
  string? sticker_url;

  /// Width of the sticker 
  int32? sticker_width;

  /// Height of the sticker
  int32? sticker_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageSticker, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents information about a venue 
class InputInlineQueryResultVenue extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVenue';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Venue result 
  Venue? venue;

  /// URL of the result thumbnail, if it exists 
  string? thumbnail_url;

  /// Thumbnail width, if known 
  int32? thumbnail_width;

  /// Thumbnail height, if known
  int32? thumbnail_height;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['venue'] != null) {
      venue = TdApiMap.fromMap(map['venue']) as Venue;
    }
    thumbnail_url = map['thumbnail_url'];
    thumbnail_width = map['thumbnail_width'];
    thumbnail_height = map['thumbnail_height'];
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to a page containing an embedded video player or a video file 
class InputInlineQueryResultVideo extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVideo';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the result 
  string? title;

  string? description;

  /// The URL of the video thumbnail (JPEG), if it exists 
  string? thumbnail_url;

  /// URL of the embedded video player or video file 
  string? video_url;

  /// MIME type of the content of the video URL, only "text/html" or "video/mp4" are currently supported
  string? mime_type;

  /// Width of the video 
  int32? video_width;

  /// Height of the video 
  int32? video_height;

  /// Video duration, in seconds
  int32? video_duration;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageVideo, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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

/// Represents a link to an opus-encoded audio file within an OGG container, single channel audio 
class InputInlineQueryResultVoiceNote extends InputInlineQueryResult {
  String get tdType => 'inputInlineQueryResultVoiceNote';

  String? extra;
  int? client_id;

  /// Unique identifier of the query result 
  string? id;

  /// Title of the voice note
  string? title;

  /// The URL of the voice note file 
  string? voice_note_url;

  /// Duration of the voice note, in seconds
  int32? voice_note_duration;

  /// The message reply markup; pass null if none. Must be of type replyMarkupInlineKeyboard or null
  ReplyMarkup? reply_markup;

  /// The content of the message to be sent. Must be one of the following types: inputMessageText, inputMessageVoiceNote, inputMessageInvoice, inputMessageLocation, inputMessageVenue or inputMessageContact
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
    if (map['reply_markup'] != null) {
      reply_markup = TdApiMap.fromMap(map['reply_markup']) as ReplyMarkup;
    }
    if (map['input_message_content'] != null) {
      input_message_content = TdApiMap.fromMap(map['input_message_content']) as InputMessageContent;
    }
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
