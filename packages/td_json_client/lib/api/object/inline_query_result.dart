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

abstract class InlineQueryResult extends TdObject {}

class InlineQueryResultArticle extends InlineQueryResult {
  String get tdType => 'inlineQueryResultArticle';

  String? extra;
  int? client_id;
  string? id;
  string? url;
  Bool? hide_url;
  string? title;
  string? description;
  Thumbnail? thumbnail;

  InlineQueryResultArticle({
    this.extra,
    this.client_id,
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
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
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
class InlineQueryResultContact extends InlineQueryResult {
  String get tdType => 'inlineQueryResultContact';

  String? extra;
  int? client_id;
  string? id;
  Contact? contact;
  Thumbnail? thumbnail;

  InlineQueryResultContact({
    this.extra,
    this.client_id,
    this.id,
    this.contact,
    this.thumbnail,
  });

  InlineQueryResultContact.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    contact = TdApiMap.fromMap(map['contact']) as Contact;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
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
class InlineQueryResultLocation extends InlineQueryResult {
  String get tdType => 'inlineQueryResultLocation';

  String? extra;
  int? client_id;
  string? id;
  Location? location;
  string? title;
  Thumbnail? thumbnail;

  InlineQueryResultLocation({
    this.extra,
    this.client_id,
    this.id,
    this.location,
    this.title,
    this.thumbnail,
  });

  InlineQueryResultLocation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    location = TdApiMap.fromMap(map['location']) as Location;
    title = map['title'];
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
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
class InlineQueryResultVenue extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVenue';

  String? extra;
  int? client_id;
  string? id;
  Venue? venue;
  Thumbnail? thumbnail;

  InlineQueryResultVenue({
    this.extra,
    this.client_id,
    this.id,
    this.venue,
    this.thumbnail,
  });

  InlineQueryResultVenue.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    venue = TdApiMap.fromMap(map['venue']) as Venue;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
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
class InlineQueryResultGame extends InlineQueryResult {
  String get tdType => 'inlineQueryResultGame';

  String? extra;
  int? client_id;
  string? id;
  Game? game;

  InlineQueryResultGame({
    this.extra,
    this.client_id,
    this.id,
    this.game,
  });

  InlineQueryResultGame.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    game = TdApiMap.fromMap(map['game']) as Game;
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
class InlineQueryResultAnimation extends InlineQueryResult {
  String get tdType => 'inlineQueryResultAnimation';

  String? extra;
  int? client_id;
  string? id;
  Animation? animation;
  string? title;

  InlineQueryResultAnimation({
    this.extra,
    this.client_id,
    this.id,
    this.animation,
    this.title,
  });

  InlineQueryResultAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    animation = TdApiMap.fromMap(map['animation']) as Animation;
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
class InlineQueryResultAudio extends InlineQueryResult {
  String get tdType => 'inlineQueryResultAudio';

  String? extra;
  int? client_id;
  string? id;
  Audio? audio;

  InlineQueryResultAudio({
    this.extra,
    this.client_id,
    this.id,
    this.audio,
  });

  InlineQueryResultAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    audio = TdApiMap.fromMap(map['audio']) as Audio;
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
class InlineQueryResultDocument extends InlineQueryResult {
  String get tdType => 'inlineQueryResultDocument';

  String? extra;
  int? client_id;
  string? id;
  Document? document;
  string? title;
  string? description;

  InlineQueryResultDocument({
    this.extra,
    this.client_id,
    this.id,
    this.document,
    this.title,
    this.description,
  });

  InlineQueryResultDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    document = TdApiMap.fromMap(map['document']) as Document;
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
class InlineQueryResultPhoto extends InlineQueryResult {
  String get tdType => 'inlineQueryResultPhoto';

  String? extra;
  int? client_id;
  string? id;
  Photo? photo;
  string? title;
  string? description;

  InlineQueryResultPhoto({
    this.extra,
    this.client_id,
    this.id,
    this.photo,
    this.title,
    this.description,
  });

  InlineQueryResultPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    photo = TdApiMap.fromMap(map['photo']) as Photo;
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
class InlineQueryResultSticker extends InlineQueryResult {
  String get tdType => 'inlineQueryResultSticker';

  String? extra;
  int? client_id;
  string? id;
  Sticker? sticker;

  InlineQueryResultSticker({
    this.extra,
    this.client_id,
    this.id,
    this.sticker,
  });

  InlineQueryResultSticker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    sticker = TdApiMap.fromMap(map['sticker']) as Sticker;
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
class InlineQueryResultVideo extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVideo';

  String? extra;
  int? client_id;
  string? id;
  Video? video;
  string? title;
  string? description;

  InlineQueryResultVideo({
    this.extra,
    this.client_id,
    this.id,
    this.video,
    this.title,
    this.description,
  });

  InlineQueryResultVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    video = TdApiMap.fromMap(map['video']) as Video;
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
class InlineQueryResultVoiceNote extends InlineQueryResult {
  String get tdType => 'inlineQueryResultVoiceNote';

  String? extra;
  int? client_id;
  string? id;
  VoiceNote? voice_note;
  string? title;

  InlineQueryResultVoiceNote({
    this.extra,
    this.client_id,
    this.id,
    this.voice_note,
    this.title,
  });

  InlineQueryResultVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
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
