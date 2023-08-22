import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_viewer.dart';

/// Returns viewers of a recent outgoing story. The method can be called if story.can_get_viewers == true. The views are returned in a reverse chronological order (i.e., in order of decreasing view_date)
/// For optimal performance, the number of returned stories is chosen by TDLib
class GetStoryViewers extends TdFunction {
  String get tdType => 'getStoryViewers';
  String get tdReturnType => 'MessageViewers';

  /// Story identifier
  int32? story_id;

  /// A viewer from which to return next viewers; pass null to get results from the beginning
  MessageViewer? offset_viewer;

  /// The maximum number of story viewers to return
  /// For optimal performance, the number of returned stories is chosen by TDLib and can be smaller than the specified limit
  int32? limit;

  GetStoryViewers({
    super.extra,
    super.client_id,
    this.story_id,
    this.offset_viewer,
    this.limit,
  });

  GetStoryViewers.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    story_id = map['story_id'];
    if (map['offset_viewer'] != null) {
      offset_viewer = TdApiMap.fromMap(map['offset_viewer']) as MessageViewer;
    }
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'story_id': story_id?.toMap(skipNulls: skipNulls),
      'offset_viewer': offset_viewer?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
