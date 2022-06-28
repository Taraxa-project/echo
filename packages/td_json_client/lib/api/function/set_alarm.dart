import 'package:td_json_client/api/base.dart';


/// Succeeds after a specified amount of time has passed. Can be called before initialization 
class SetAlarm extends TdFunction {
  String get tdType => 'setAlarm';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;

  /// Number of seconds before the function returns
  double? seconds;

  SetAlarm({
    this.extra,
    this.client_id,
    this.seconds,
  });

  SetAlarm.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    seconds = map['seconds'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'seconds': seconds?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
