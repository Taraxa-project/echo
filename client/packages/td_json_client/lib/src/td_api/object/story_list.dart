import 'package:td_json_client/src/td_api/td.dart';

/// Describes a list of stories
abstract class StoryList extends TdObject {
  StoryList({super.extra, super.client_id});
}

/// The list of stories, shown in the main chat list and folder chat lists
class StoryListMain extends StoryList {
  String get tdType => 'storyListMain';

  StoryListMain({
    super.extra,
    super.client_id,
  });

  StoryListMain.fromMap(Map<String, dynamic> map) {
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

/// The list of stories, shown in the Arvhive chat list
class StoryListArchive extends StoryList {
  String get tdType => 'storyListArchive';

  StoryListArchive({
    super.extra,
    super.client_id,
  });

  StoryListArchive.fromMap(Map<String, dynamic> map) {
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
