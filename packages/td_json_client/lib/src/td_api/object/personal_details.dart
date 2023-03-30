import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/date.dart';

/// Contains the user's personal details
class PersonalDetails extends TdObject {
  String get tdType => 'personalDetails';

  /// First name of the user written in English; 1-255 characters
  string? first_name;

  /// Middle name of the user written in English; 0-255 characters
  string? middle_name;

  /// Last name of the user written in English; 1-255 characters
  string? last_name;

  /// Native first name of the user; 1-255 characters
  string? native_first_name;

  /// Native middle name of the user; 0-255 characters
  string? native_middle_name;

  /// Native last name of the user; 1-255 characters
  string? native_last_name;

  /// Birthdate of the user
  Date? birthdate;

  /// Gender of the user, "male" or "female"
  string? gender;

  /// A two-letter ISO 3166-1 alpha-2 country code of the user's country
  string? country_code;

  /// A two-letter ISO 3166-1 alpha-2 country code of the user's residence country
  string? residence_country_code;

  PersonalDetails({
    super.extra,
    super.client_id,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.native_first_name,
    this.native_middle_name,
    this.native_last_name,
    this.birthdate,
    this.gender,
    this.country_code,
    this.residence_country_code,
  });

  PersonalDetails.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    first_name = map['first_name'];
    middle_name = map['middle_name'];
    last_name = map['last_name'];
    native_first_name = map['native_first_name'];
    native_middle_name = map['native_middle_name'];
    native_last_name = map['native_last_name'];
    if (map['birthdate'] != null) {
      birthdate = TdApiMap.fromMap(map['birthdate']) as Date;
    }
    gender = map['gender'];
    country_code = map['country_code'];
    residence_country_code = map['residence_country_code'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'first_name': first_name?.toMap(skipNulls: skipNulls),
      'middle_name': middle_name?.toMap(skipNulls: skipNulls),
      'last_name': last_name?.toMap(skipNulls: skipNulls),
      'native_first_name': native_first_name?.toMap(skipNulls: skipNulls),
      'native_middle_name': native_middle_name?.toMap(skipNulls: skipNulls),
      'native_last_name': native_last_name?.toMap(skipNulls: skipNulls),
      'birthdate': birthdate?.toMap(skipNulls: skipNulls),
      'gender': gender?.toMap(skipNulls: skipNulls),
      'country_code': country_code?.toMap(skipNulls: skipNulls),
      'residence_country_code':
          residence_country_code?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
