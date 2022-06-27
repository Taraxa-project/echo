import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class AddSavedAnimation extends TdFunction {
  String get tdType => 'addSavedAnimation';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  InputFile? animation;

  AddSavedAnimation({
    this.extra,
    this.client_id,
    this.animation,
  });

  AddSavedAnimation.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    animation = TdApiMap.fromMap(map['animation']) as InputFile;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'animation': animation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
