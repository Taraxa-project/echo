import 'package:td_json_client/api/base.dart';


/// Searches for a background by its name 
class SearchBackground extends TdFunction {
  String get tdType => 'searchBackground';
  String get tdReturnType => 'Background';


  /// The name of the background
  string? name;

  SearchBackground({
    super.extra,
    super.client_id,
    this.name,
  });

  SearchBackground.fromMap(Map<String, dynamic> map) {
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
