import 'package:td_json_client/api/base.dart';


/// Removes background from the list of installed backgrounds 
class RemoveBackground extends TdFunction {
  String get tdType => 'removeBackground';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// The background identifier
  int64? background_id;

  RemoveBackground({
    this.extra,
    this.client_id,
    this.background_id,
  });

  RemoveBackground.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    background_id = map['background_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'background_id': background_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
