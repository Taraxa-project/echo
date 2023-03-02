import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/rich_text.dart';


/// Contains a caption of an instant view web page block, consisting of a text and a trailing credit 
class PageBlockCaption extends TdObject {
  String get tdType => 'pageBlockCaption';


  /// Content of the caption 
  RichText? text;

  /// Block credit (like HTML tag <cite>)
  RichText? credit;

  PageBlockCaption({
    super.extra,
    super.client_id,
    this.text,
    this.credit,
  });

  PageBlockCaption.fromMap(Map<String, dynamic> map) {
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
