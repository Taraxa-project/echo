import 'package:td_json_client/api/base.dart';


/// Searches for recently used hashtags by their prefix 
class SearchHashtags extends TdFunction {
  String get tdType => 'searchHashtags';
  String get tdReturnType => 'Hashtags';


  /// Hashtag prefix to search for 
  string? prefix;

  /// The maximum number of hashtags to be returned
  int32? limit;

  SearchHashtags({
    super.extra,
    super.client_id,
    this.prefix,
    this.limit,
  });

  SearchHashtags.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    prefix = map['prefix'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'prefix': prefix?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
