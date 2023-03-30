import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/message_auto_delete_time.dart';

/// Changes the default message auto-delete time for new chats
class SetDefaultMessageAutoDeleteTime extends TdFunction {
  String get tdType => 'setDefaultMessageAutoDeleteTime';
  String get tdReturnType => 'Ok';

  /// New default message auto-delete time; must be from 0 up to 365 * 86400 and be divisible by 86400. If 0, then messages aren't deleted automatically
  MessageAutoDeleteTime? message_auto_delete_time;

  SetDefaultMessageAutoDeleteTime({
    super.extra,
    super.client_id,
    this.message_auto_delete_time,
  });

  SetDefaultMessageAutoDeleteTime.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message_auto_delete_time'] != null) {
      message_auto_delete_time =
          TdApiMap.fromMap(map['message_auto_delete_time'])
              as MessageAutoDeleteTime;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message_auto_delete_time':
          message_auto_delete_time?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
