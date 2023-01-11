import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/contact.dart';
import 'package:td_json_client/api/object/location.dart';
import 'package:td_json_client/api/object/venue.dart';
import 'package:td_json_client/api/object/game.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/document.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/sticker.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/voice_note.dart';

/// Represents a single result of an inline query
abstract class InlineQueryResult extends TdObject {
  InlineQueryResult({super.extra, super.client_id});
}


/// Represents a link to an article or web page
class InlineQueryResultArticle extends InlineQueryResult {
  String get tdType => 'inlineQueryResultArticle';


  /// Unique identifier of the query result
  string? id;

  /// URL of the result, if it exists
  string? url;

  /// True, if the URL must be not shown
  Bool? hide_url;

  /// Title of the result
  string? title;

  string? description;

  /// Result thumbnail in JPEG format; may be null
  Thumbnail? thumbnail;

  InlineQueryResultArticle({
    super.extra,
    super.client_id,
    this.id,
    this.url,
    this.hide_url,
    this.title,
    this.description,
    this.thumbnail,
  });

  InlineQueryResultArticle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    url = map['url'];
    hide_url = map['hide_url'];
    title = map['title'];
    description = map['description'];
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
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
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a user contact
class InlineQueryResultContact extends InlineQueryResult {
  String get tdType => 'inlineQueryResultContact';


  /// Unique identifier of the query result
  string? id;

  /// A user contact
  Contact? contact;

  /// Result thumbnail in JPEG format; may be null
  Thumbnail? thumbnail;

  InlineQueryResultContact({
    super.extra,
    super.client_id,
    this.id,
    this.contact,
    this.thumbnail,
  });

  InlineQueryResultContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['contact'] != null) {
      contact = TdApiMap.fromMap(map['contact']) as Contact;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'contact': contact?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a point on the map
class InlineQueryResultLocation extends InlineQueryResult {
  String get tdType => 'inlineQueryResultLocation';


  /// Unique identifier of the query result
  string? id;

  /// Location result
  Location? location;

  /// Title of the result
  string? title;

  /// Result thumbnail in JPEG format; may be null
  Thumbnail? thumbnail;

  InlineQueryResultLocation({
    super.extra,
    super.client_id,
    this.id,
    this.location,
    this.title,
    this.thumbnail,
  });

  InlineQueryResultLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
    title = map['title'];
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents information about a venue
class InlineQueryResultVenue extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVenue';


  /// Unique identifier of the query result
  string? id;

  /// Venue result
  Venue? venue;

  /// Result thumbnail in JPEG format; may be null
  Thumbnail? thumbnail;

  InlineQueryResultVenue({
    super.extra,
    super.client_id,
    this.id,
    this.venue,
    this.thumbnail,
  });

  InlineQueryResultVenue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['venue'] != null) {
      venue = TdApiMap.fromMap(map['venue']) as Venue;
    }
    if (map['thumbnail'] != null) {
      thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'venue': venue?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents information about a game
class InlineQueryResultGame extends InlineQueryResult {
  String get tdType => 'inlineQueryResultGame';


  /// Unique identifier of the query result
  string? id;

  /// Game result
  Game? game;

  InlineQueryResultGame({
    super.extra,
    super.client_id,
    this.id,
    this.game,
  });

  InlineQueryResultGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['game'] != null) {
      game = TdApiMap.fromMap(map['game']) as Game;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'game': game?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents an animation file
class InlineQueryResultAnimation extends InlineQueryResult {
  String get tdType => 'inlineQueryResultAnimation';


  /// Unique identifier of the query result
  string? id;

  /// Animation file
  Animation? animation;

  /// Animation title
  string? title;

  InlineQueryResultAnimation({
    super.extra,
    super.client_id,
    this.id,
    this.animation,
    this.title,
  });

  InlineQueryResultAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents an audio file
class InlineQueryResultAudio extends InlineQueryResult {
  String get tdType => 'inlineQueryResultAudio';


  /// Unique identifier of the query result
  string? id;

  /// Audio file
  Audio? audio;

  InlineQueryResultAudio({
    super.extra,
    super.client_id,
    this.id,
    this.audio,
  });

  InlineQueryResultAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as Audio;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'audio': audio?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a document
class InlineQueryResultDocument extends InlineQueryResult {
  String get tdType => 'inlineQueryResultDocument';


  /// Unique identifier of the query result
  string? id;

  /// Document
  Document? document;

  /// Document title
  string? title;

  string? description;

  InlineQueryResultDocument({
    super.extra,
    super.client_id,
    this.id,
    this.document,
    this.title,
    this.description,
  });

  InlineQueryResultDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['document'] != null) {
      document = TdApiMap.fromMap(map['document']) as Document;
    }
    title = map['title'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a photo
class InlineQueryResultPhoto extends InlineQueryResult {
  String get tdType => 'inlineQueryResultPhoto';


  /// Unique identifier of the query result
  string? id;

  /// Photo
  Photo? photo;

  /// Title of the result, if known
  string? title;

  string? description;

  InlineQueryResultPhoto({
    super.extra,
    super.client_id,
    this.id,
    this.photo,
    this.title,
    this.description,
  });

  InlineQueryResultPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    title = map['title'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a sticker
class InlineQueryResultSticker extends InlineQueryResult {
  String get tdType => 'inlineQueryResultSticker';


  /// Unique identifier of the query result
  string? id;

  /// Sticker
  Sticker? sticker;

  InlineQueryResultSticker({
    super.extra,
    super.client_id,
    this.id,
    this.sticker,
  });

  InlineQueryResultSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['sticker'] != null) {
      sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'sticker': sticker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a video
class InlineQueryResultVideo extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVideo';


  /// Unique identifier of the query result
  string? id;

  /// Video
  Video? video;

  /// Title of the video
  string? title;

  string? description;

  InlineQueryResultVideo({
    super.extra,
    super.client_id,
    this.id,
    this.video,
    this.title,
    this.description,
  });

  InlineQueryResultVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
    }
    title = map['title'];
    description = map['description'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'description': description?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Represents a voice note
class InlineQueryResultVoiceNote extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVoiceNote';


  /// Unique identifier of the query result
  string? id;

  /// Voice note
  VoiceNote? voice_note;

  /// Title of the voice note
  string? title;

  InlineQueryResultVoiceNote({
    super.extra,
    super.client_id,
    this.id,
    this.voice_note,
    this.title,
  });

  InlineQueryResultVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    }
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
