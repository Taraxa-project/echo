import 'package:td_json_client/api/base.dart';


/// Removes a hashtag from the list of recently used hashtags 
class RemoveRecentHashtag extends TdFunction {
  String get tdType => 'removeRecentHashtag';
  String get tdReturnType => 'Ok';


  /// Hashtag to delete
  string? hashtag;

  RemoveRecentHashtag({
    super.extra,
    super.client_id,
    this.hashtag,
  });

  RemoveRecentHashtag.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    hashtag = map['hashtag'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'hashtag': hashtag?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
