import 'package:td_json_client/api/base.dart';


/// Finishes user registration. Works only when the current authorization state is authorizationStateWaitRegistration
class RegisterUser extends TdFunction {
  String get tdType => 'registerUser';
  String get tdReturnType => 'Ok';


  /// The first name of the user; 1-64 characters 
  string? first_name;

  /// The last name of the user; 0-64 characters
  string? last_name;

  RegisterUser({
    super.extra,
    super.client_id,
    this.first_name,
    this.last_name,
  });

  RegisterUser.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
