import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/rich_text.dart';
import 'package:td_json_client/api/object/page_block_list_item.dart';
import 'package:td_json_client/api/object/animation.dart';
import 'package:td_json_client/api/object/page_block_caption.dart';
import 'package:td_json_client/api/object/audio.dart';
import 'package:td_json_client/api/object/photo.dart';
import 'package:td_json_client/api/object/video.dart';
import 'package:td_json_client/api/object/voice_note.dart';
import 'package:td_json_client/api/object/chat_photo_info.dart';
import 'package:td_json_client/api/object/page_block_table_cell.dart';
import 'package:td_json_client/api/object/page_block_related_article.dart';
import 'package:td_json_client/api/object/location.dart';

/// Describes a block of an instant view web page
abstract class PageBlock extends TdObject {}


/// The title of a page 
class PageBlockTitle extends PageBlock {
  String get tdType => 'pageBlockTitle';

  String? extra;
  int? client_id;

  /// Title
  RichText? title;

  PageBlockTitle({
    this.extra,
    this.client_id,
    this.title,
  });

  PageBlockTitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['title'] != null) {
      title = TdApiMap.fromMap(map['title']) as RichText;
    }
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

/// The subtitle of a page 
class PageBlockSubtitle extends PageBlock {
  String get tdType => 'pageBlockSubtitle';

  String? extra;
  int? client_id;

  /// Subtitle
  RichText? subtitle;

  PageBlockSubtitle({
    this.extra,
    this.client_id,
    this.subtitle,
  });

  PageBlockSubtitle.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['subtitle'] != null) {
      subtitle = TdApiMap.fromMap(map['subtitle']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'subtitle': subtitle?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The author and publishing date of a page 
class PageBlockAuthorDate extends PageBlock {
  String get tdType => 'pageBlockAuthorDate';

  String? extra;
  int? client_id;

  /// Author 
  RichText? author;

  /// Point in time (Unix timestamp) when the article was published; 0 if unknown
  int32? publish_date;

  PageBlockAuthorDate({
    this.extra,
    this.client_id,
    this.author,
    this.publish_date,
  });

  PageBlockAuthorDate.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['author'] != null) {
      author = TdApiMap.fromMap(map['author']) as RichText;
    }
    publish_date = map['publish_date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'author': author?.toMap(skipNulls: skipNulls),
      'publish_date': publish_date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A header 
class PageBlockHeader extends PageBlock {
  String get tdType => 'pageBlockHeader';

  String? extra;
  int? client_id;

  /// Header
  RichText? header;

  PageBlockHeader({
    this.extra,
    this.client_id,
    this.header,
  });

  PageBlockHeader.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['header'] != null) {
      header = TdApiMap.fromMap(map['header']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'header': header?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A subheader 
class PageBlockSubheader extends PageBlock {
  String get tdType => 'pageBlockSubheader';

  String? extra;
  int? client_id;

  /// Subheader
  RichText? subheader;

  PageBlockSubheader({
    this.extra,
    this.client_id,
    this.subheader,
  });

  PageBlockSubheader.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['subheader'] != null) {
      subheader = TdApiMap.fromMap(map['subheader']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'subheader': subheader?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A kicker 
class PageBlockKicker extends PageBlock {
  String get tdType => 'pageBlockKicker';

  String? extra;
  int? client_id;

  /// Kicker
  RichText? kicker;

  PageBlockKicker({
    this.extra,
    this.client_id,
    this.kicker,
  });

  PageBlockKicker.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['kicker'] != null) {
      kicker = TdApiMap.fromMap(map['kicker']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'kicker': kicker?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A text paragraph 
class PageBlockParagraph extends PageBlock {
  String get tdType => 'pageBlockParagraph';

  String? extra;
  int? client_id;

  /// Paragraph text
  RichText? text;

  PageBlockParagraph({
    this.extra,
    this.client_id,
    this.text,
  });

  PageBlockParagraph.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as RichText;
    }
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

/// A preformatted text paragraph 
class PageBlockPreformatted extends PageBlock {
  String get tdType => 'pageBlockPreformatted';

  String? extra;
  int? client_id;

  /// Paragraph text 
  RichText? text;

  /// Programming language for which the text needs to be formatted
  string? language;

  PageBlockPreformatted({
    this.extra,
    this.client_id,
    this.text,
    this.language,
  });

  PageBlockPreformatted.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as RichText;
    }
    language = map['language'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'language': language?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// The footer of a page 
class PageBlockFooter extends PageBlock {
  String get tdType => 'pageBlockFooter';

  String? extra;
  int? client_id;

  /// Footer
  RichText? footer;

  PageBlockFooter({
    this.extra,
    this.client_id,
    this.footer,
  });

  PageBlockFooter.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['footer'] != null) {
      footer = TdApiMap.fromMap(map['footer']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'footer': footer?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An empty block separating a page
class PageBlockDivider extends PageBlock {
  String get tdType => 'pageBlockDivider';

  String? extra;
  int? client_id;

  PageBlockDivider({
    this.extra,
    this.client_id,
  });

  PageBlockDivider.fromMap(Map<String, dynamic> map) {
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

/// An invisible anchor on a page, which can be used in a URL to open the page from the specified anchor 
class PageBlockAnchor extends PageBlock {
  String get tdType => 'pageBlockAnchor';

  String? extra;
  int? client_id;

  /// Name of the anchor
  string? name;

  PageBlockAnchor({
    this.extra,
    this.client_id,
    this.name,
  });

  PageBlockAnchor.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    name = map['name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'name': name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A list of data blocks 
class PageBlockList extends PageBlock {
  String get tdType => 'pageBlockList';

  String? extra;
  int? client_id;

  /// The items of the list
  vector<PageBlockListItem>? items;

  PageBlockList({
    this.extra,
    this.client_id,
    this.items,
  });

  PageBlockList.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['items'] != null) {
      items = [];
      for (var someValue in map['items']) {
        if (someValue != null) {
          items?.add(TdApiMap.fromMap(someValue) as PageBlockListItem);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'items': items?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A block quote 
class PageBlockBlockQuote extends PageBlock {
  String get tdType => 'pageBlockBlockQuote';

  String? extra;
  int? client_id;

  /// Quote text 
  RichText? text;

  /// Quote credit
  RichText? credit;

  PageBlockBlockQuote({
    this.extra,
    this.client_id,
    this.text,
    this.credit,
  });

  PageBlockBlockQuote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as RichText;
    }
    if (map['credit'] != null) {
      credit = TdApiMap.fromMap(map['credit']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'credit': credit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A pull quote 
class PageBlockPullQuote extends PageBlock {
  String get tdType => 'pageBlockPullQuote';

  String? extra;
  int? client_id;

  /// Quote text 
  RichText? text;

  /// Quote credit
  RichText? credit;

  PageBlockPullQuote({
    this.extra,
    this.client_id,
    this.text,
    this.credit,
  });

  PageBlockPullQuote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['text'] != null) {
      text = TdApiMap.fromMap(map['text']) as RichText;
    }
    if (map['credit'] != null) {
      credit = TdApiMap.fromMap(map['credit']) as RichText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'credit': credit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An animation 
class PageBlockAnimation extends PageBlock {
  String get tdType => 'pageBlockAnimation';

  String? extra;
  int? client_id;

  /// Animation file; may be null 
  Animation? animation;

  /// Animation caption 
  PageBlockCaption? caption;

  /// True, if the animation must be played automatically
  Bool? need_autoplay;

  PageBlockAnimation({
    this.extra,
    this.client_id,
    this.animation,
    this.caption,
    this.need_autoplay,
  });

  PageBlockAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['animation'] != null) {
      animation = TdApiMap.fromMap(map['animation']) as Animation;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
    need_autoplay = map['need_autoplay'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'need_autoplay': need_autoplay?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An audio file 
class PageBlockAudio extends PageBlock {
  String get tdType => 'pageBlockAudio';

  String? extra;
  int? client_id;

  /// Audio file; may be null 
  Audio? audio;

  /// Audio file caption
  PageBlockCaption? caption;

  PageBlockAudio({
    this.extra,
    this.client_id,
    this.audio,
    this.caption,
  });

  PageBlockAudio.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['audio'] != null) {
      audio = TdApiMap.fromMap(map['audio']) as Audio;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
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

/// A photo 
class PageBlockPhoto extends PageBlock {
  String get tdType => 'pageBlockPhoto';

  String? extra;
  int? client_id;

  /// Photo file; may be null 
  Photo? photo;

  /// Photo caption 
  PageBlockCaption? caption;

  /// URL that needs to be opened when the photo is clicked
  string? url;

  PageBlockPhoto({
    this.extra,
    this.client_id,
    this.photo,
    this.caption,
    this.url,
  });

  PageBlockPhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as Photo;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
    url = map['url'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A video 
class PageBlockVideo extends PageBlock {
  String get tdType => 'pageBlockVideo';

  String? extra;
  int? client_id;

  /// Video file; may be null 
  Video? video;

  /// Video caption 
  PageBlockCaption? caption;

  /// True, if the video must be played automatically 
  Bool? need_autoplay;

  /// True, if the video must be looped
  Bool? is_looped;

  PageBlockVideo({
    this.extra,
    this.client_id,
    this.video,
    this.caption,
    this.need_autoplay,
    this.is_looped,
  });

  PageBlockVideo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['video'] != null) {
      video = TdApiMap.fromMap(map['video']) as Video;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
    need_autoplay = map['need_autoplay'];
    is_looped = map['is_looped'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'video': video?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'need_autoplay': need_autoplay?.toMap(skipNulls: skipNulls),
      'is_looped': is_looped?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A voice note 
class PageBlockVoiceNote extends PageBlock {
  String get tdType => 'pageBlockVoiceNote';

  String? extra;
  int? client_id;

  /// Voice note; may be null 
  VoiceNote? voice_note;

  /// Voice note caption
  PageBlockCaption? caption;

  PageBlockVoiceNote({
    this.extra,
    this.client_id,
    this.voice_note,
    this.caption,
  });

  PageBlockVoiceNote.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['voice_note'] != null) {
      voice_note = TdApiMap.fromMap(map['voice_note']) as VoiceNote;
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'voice_note': voice_note?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A page cover 
class PageBlockCover extends PageBlock {
  String get tdType => 'pageBlockCover';

  String? extra;
  int? client_id;

  /// Cover
  PageBlock? cover;

  PageBlockCover({
    this.extra,
    this.client_id,
    this.cover,
  });

  PageBlockCover.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    cover = map['cover'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'cover': cover?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An embedded web page 
class PageBlockEmbedded extends PageBlock {
  String get tdType => 'pageBlockEmbedded';

  String? extra;
  int? client_id;

  /// Web page URL, if available 
  string? url;

  /// HTML-markup of the embedded page 
  string? html;

  /// Poster photo, if available; may be null 
  Photo? poster_photo;

  /// Block width; 0 if unknown 
  int32? width;

  /// Block height; 0 if unknown 
  int32? height;

  /// Block caption 
  PageBlockCaption? caption;

  /// True, if the block must be full width 
  Bool? is_full_width;

  /// True, if scrolling needs to be allowed
  Bool? allow_scrolling;

  PageBlockEmbedded({
    this.extra,
    this.client_id,
    this.url,
    this.html,
    this.poster_photo,
    this.width,
    this.height,
    this.caption,
    this.is_full_width,
    this.allow_scrolling,
  });

  PageBlockEmbedded.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    html = map['html'];
    if (map['poster_photo'] != null) {
      poster_photo = TdApiMap.fromMap(map['poster_photo']) as Photo;
    }
    width = map['width'];
    height = map['height'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
    is_full_width = map['is_full_width'];
    allow_scrolling = map['allow_scrolling'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'html': html?.toMap(skipNulls: skipNulls),
      'poster_photo': poster_photo?.toMap(skipNulls: skipNulls),
      'width': width?.toMap(skipNulls: skipNulls),
      'height': height?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'is_full_width': is_full_width?.toMap(skipNulls: skipNulls),
      'allow_scrolling': allow_scrolling?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// An embedded post 
class PageBlockEmbeddedPost extends PageBlock {
  String get tdType => 'pageBlockEmbeddedPost';

  String? extra;
  int? client_id;

  /// Web page URL 
  string? url;

  /// Post author 
  string? author;

  /// Post author photo; may be null 
  Photo? author_photo;

  /// Point in time (Unix timestamp) when the post was created; 0 if unknown 
  int32? date;

  /// Post content 
  vector<PageBlock>? page_blocks;

  /// Post caption
  PageBlockCaption? caption;

  PageBlockEmbeddedPost({
    this.extra,
    this.client_id,
    this.url,
    this.author,
    this.author_photo,
    this.date,
    this.page_blocks,
    this.caption,
  });

  PageBlockEmbeddedPost.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    url = map['url'];
    author = map['author'];
    if (map['author_photo'] != null) {
      author_photo = TdApiMap.fromMap(map['author_photo']) as Photo;
    }
    date = map['date'];
    if (map['page_blocks'] != null) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(someValue);
      }
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'url': url?.toMap(skipNulls: skipNulls),
      'author': author?.toMap(skipNulls: skipNulls),
      'author_photo': author_photo?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A collage 
class PageBlockCollage extends PageBlock {
  String get tdType => 'pageBlockCollage';

  String? extra;
  int? client_id;

  /// Collage item contents 
  vector<PageBlock>? page_blocks;

  /// Block caption
  PageBlockCaption? caption;

  PageBlockCollage({
    this.extra,
    this.client_id,
    this.page_blocks,
    this.caption,
  });

  PageBlockCollage.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['page_blocks'] != null) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(someValue);
      }
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A slideshow 
class PageBlockSlideshow extends PageBlock {
  String get tdType => 'pageBlockSlideshow';

  String? extra;
  int? client_id;

  /// Slideshow item contents 
  vector<PageBlock>? page_blocks;

  /// Block caption
  PageBlockCaption? caption;

  PageBlockSlideshow({
    this.extra,
    this.client_id,
    this.page_blocks,
    this.caption,
  });

  PageBlockSlideshow.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['page_blocks'] != null) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(someValue);
      }
    }
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A link to a chat 
class PageBlockChatLink extends PageBlock {
  String get tdType => 'pageBlockChatLink';

  String? extra;
  int? client_id;

  /// Chat title 
  string? title;

  /// Chat photo; may be null 
  ChatPhotoInfo? photo;

  /// Chat username, by which all other information about the chat can be resolved
  string? username;

  PageBlockChatLink({
    this.extra,
    this.client_id,
    this.title,
    this.photo,
    this.username,
  });

  PageBlockChatLink.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    title = map['title'];
    if (map['photo'] != null) {
      photo = TdApiMap.fromMap(map['photo']) as ChatPhotoInfo;
    }
    username = map['username'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
      'photo': photo?.toMap(skipNulls: skipNulls),
      'username': username?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A table 
class PageBlockTable extends PageBlock {
  String get tdType => 'pageBlockTable';

  String? extra;
  int? client_id;

  /// Table caption 
  RichText? caption;

  /// Table cells 
  vector<vector<PageBlockTableCell>>? cells;

  /// True, if the table is bordered 
  Bool? is_bordered;

  /// True, if the table is striped
  Bool? is_striped;

  PageBlockTable({
    this.extra,
    this.client_id,
    this.caption,
    this.cells,
    this.is_bordered,
    this.is_striped,
  });

  PageBlockTable.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as RichText;
    }
    if (map['cells'] != null) {
      cells = [];
      for (var someValues in map['cells']) {
        var objs = <PageBlockTableCell>[];
        for (var someValue in someValues) {
          if (someValue != null) {
            objs.add(TdApiMap.fromMap(someValue) as PageBlockTableCell);
          }
        }
        cells?.add(objs);
      }
    }
    is_bordered = map['is_bordered'];
    is_striped = map['is_striped'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'caption': caption?.toMap(skipNulls: skipNulls),
      'cells': cells?.toMap(skipNulls: skipNulls),
      'is_bordered': is_bordered?.toMap(skipNulls: skipNulls),
      'is_striped': is_striped?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A collapsible block 
class PageBlockDetails extends PageBlock {
  String get tdType => 'pageBlockDetails';

  String? extra;
  int? client_id;

  /// Always visible heading for the block 
  RichText? header;

  /// Block contents 
  vector<PageBlock>? page_blocks;

  /// True, if the block is open by default
  Bool? is_open;

  PageBlockDetails({
    this.extra,
    this.client_id,
    this.header,
    this.page_blocks,
    this.is_open,
  });

  PageBlockDetails.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['header'] != null) {
      header = TdApiMap.fromMap(map['header']) as RichText;
    }
    if (map['page_blocks'] != null) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(someValue);
      }
    }
    is_open = map['is_open'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'header': header?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
      'is_open': is_open?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// Related articles 
class PageBlockRelatedArticles extends PageBlock {
  String get tdType => 'pageBlockRelatedArticles';

  String? extra;
  int? client_id;

  /// Block header 
  RichText? header;

  /// List of related articles
  vector<PageBlockRelatedArticle>? articles;

  PageBlockRelatedArticles({
    this.extra,
    this.client_id,
    this.header,
    this.articles,
  });

  PageBlockRelatedArticles.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['header'] != null) {
      header = TdApiMap.fromMap(map['header']) as RichText;
    }
    if (map['articles'] != null) {
      articles = [];
      for (var someValue in map['articles']) {
        if (someValue != null) {
          articles?.add(TdApiMap.fromMap(someValue) as PageBlockRelatedArticle);
        }
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'header': header?.toMap(skipNulls: skipNulls),
      'articles': articles?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A map 
class PageBlockMap extends PageBlock {
  String get tdType => 'pageBlockMap';

  String? extra;
  int? client_id;

  /// Location of the map center 
  Location? location;

  /// Map zoom level 
  int32? zoom;

  /// Map width 
  int32? width;

  /// Map height 
  int32? height;

  /// Block caption
  PageBlockCaption? caption;

  PageBlockMap({
    this.extra,
    this.client_id,
    this.location,
    this.zoom,
    this.width,
    this.height,
    this.caption,
  });

  PageBlockMap.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['location'] != null) {
      location = TdApiMap.fromMap(map['location']) as Location;
    }
    zoom = map['zoom'];
    width = map['width'];
    height = map['height'];
    if (map['caption'] != null) {
      caption = TdApiMap.fromMap(map['caption']) as PageBlockCaption;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'location': location?.toMap(skipNulls: skipNulls),
      'zoom': zoom?.toMap(skipNulls: skipNulls),
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
