import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/page_block.dart';
import 'package:td_json_client/api/object/internal_link_type.dart';

class WebPageInstantView extends TdObject {
  String get tdType => 'webPageInstantView';

  String? extra;
  int? client_id;
  vector<PageBlock>? page_blocks;
  int32? view_count;
  int32? version;
  Bool? is_rtl;
  Bool? is_full;
  InternalLinkType? feedback_link;

  WebPageInstantView({
    this.extra,
    this.client_id,
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
    if (map['page_blocks']) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(TdApiMap.fromMap(someValue) as PageBlock);
      }
    }
    view_count = map['view_count'];
    version = map['version'];
    is_rtl = map['is_rtl'];
    is_full = map['is_full'];
    feedback_link = TdApiMap.fromMap(map['feedback_link']) as InternalLinkType;
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
