import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/rich_text.dart';
import 'package:td_json_client/api/object/page_block_horizontal_alignment.dart';
import 'package:td_json_client/api/object/page_block_vertical_alignment.dart';


/// Represents a cell of a table 
class PageBlockTableCell extends TdObject {
  String get tdType => 'pageBlockTableCell';

  String? extra;
  int? client_id;

  /// Cell text; may be null. If the text is null, then the cell must be invisible 
  RichText? text;

  /// True, if it is a header cell
  Bool? is_header;

  /// The number of columns the cell spans 
  int32? colspan;

  /// The number of rows the cell spans
  int32? rowspan;

  /// Horizontal cell content alignment 
  PageBlockHorizontalAlignment? align;

  /// Vertical cell content alignment
  PageBlockVerticalAlignment? valign;

  PageBlockTableCell({
    this.extra,
    this.client_id,
    this.text,
    this.is_header,
    this.colspan,
    this.rowspan,
    this.align,
    this.valign,
  });

  PageBlockTableCell.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    text = TdApiMap.fromMap(map['text']) as RichText;
    is_header = map['is_header'];
    colspan = map['colspan'];
    rowspan = map['rowspan'];
    align = TdApiMap.fromMap(map['align']) as PageBlockHorizontalAlignment;
    valign = TdApiMap.fromMap(map['valign']) as PageBlockVerticalAlignment;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'text': text?.toMap(skipNulls: skipNulls),
      'is_header': is_header?.toMap(skipNulls: skipNulls),
      'colspan': colspan?.toMap(skipNulls: skipNulls),
      'rowspan': rowspan?.toMap(skipNulls: skipNulls),
      'align': align?.toMap(skipNulls: skipNulls),
      'valign': valign?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
