import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/page_block.dart';
import 'package:td_json_client/src/td_api/object/internal_link_type.dart';

/// Describes an instant view page for a web page
class WebPageInstantView extends TdObject {
  String get tdType => 'webPageInstantView';

  /// Content of the web page
  vector<PageBlock>? page_blocks;

  /// Number of the instant view views; 0 if unknown
  int32? view_count;

  /// Version of the instant view; currently, can be 1 or 2
  int32? version;

  /// True, if the instant view must be shown from right to left
  Bool? is_rtl;

  /// True, if the instant view contains the full page. A network request might be needed to get the full web page instant view
  Bool? is_full;

  /// An internal link to be opened to leave feedback about the instant view
  InternalLinkType? feedback_link;

  WebPageInstantView({
    super.extra,
    super.client_id,
    this.page_blocks,
    this.view_count,
    this.version,
    this.is_rtl,
    this.is_full,
    this.feedback_link,
  });

  WebPageInstantView.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['page_blocks'] != null) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        if (someValue != null) {
          page_blocks?.add(TdApiMap.fromMap(someValue) as PageBlock);
        }
      }
    }
    view_count = map['view_count'];
    version = map['version'];
    is_rtl = map['is_rtl'];
    is_full = map['is_full'];
    if (map['feedback_link'] != null) {
      feedback_link = TdApiMap.fromMap(map['feedback_link']) as InternalLinkType;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
      'view_count': view_count?.toMap(skipNulls: skipNulls),
      'version': version?.toMap(skipNulls: skipNulls),
      'is_rtl': is_rtl?.toMap(skipNulls: skipNulls),
      'is_full': is_full?.toMap(skipNulls: skipNulls),
      'feedback_link': feedback_link?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
