import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/formatted_text.dart';


/// Sets support information for the given user; for Telegram support only 
class SetUserSupportInfo extends TdFunction {
  String get tdType => 'setUserSupportInfo';
  String get tdReturnType => 'UserSupportInfo';


  /// User identifier 
  int53? user_id;

  /// New information message
  FormattedText? message;

  SetUserSupportInfo({
    super.extra,
    super.client_id,
    this.user_id,
    this.message,
  });

  SetUserSupportInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as FormattedText;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
