import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/input_file.dart';


/// Adds a new notification sound to the list of saved notification sounds. The new notification sound is added to the top of the list. If it is already in the list, its position isn't changed 
class AddSavedNotificationSound extends TdFunction {
  String get tdType => 'addSavedNotificationSound';
  String get tdReturnType => 'NotificationSound';

  String? extra;
  int? client_id;

  /// Notification sound file to add
  InputFile? sound;

  AddSavedNotificationSound({
    this.extra,
    this.client_id,
    this.sound,
  });

  AddSavedNotificationSound.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['sound'] != null) {
      sound = TdApiMap.fromMap(map['sound']) as InputFile;
    }
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
