import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';

class AddSavedNotificationSound extends TdFunction {
  String get tdType => 'addSavedNotificationSound';
  String get tdReturnType => 'NotificationSound';

  string? extra;
  int? client_id;
  InputFile? sound;

  AddSavedNotificationSound({
    this.extra,
    this.client_id,
    this.sound,
  });

  AddSavedNotificationSound.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    sound = TdApiMap.fromMap(map['sound']) as InputFile;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'sound': sound?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
