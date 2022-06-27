import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/page_block.dart';

class PageBlockListItem extends TdObject {
  String get tdType => 'pageBlockListItem';

  string? extra;
  int? client_id;
  string? label;
  vector<PageBlock>? page_blocks;

  PageBlockListItem({
    this.extra,
    this.client_id,
    this.label,
    this.page_blocks,
  });

  PageBlockListItem.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    label = map['label'];
    if (map['page_blocks']) {
      page_blocks = [];
      for (var someValue in map['page_blocks']) {
        page_blocks?.add(TdApiMap.fromMap(someValue) as PageBlock);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'label': label?.toMap(skipNulls: skipNulls),
      'page_blocks': page_blocks?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
