import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/formatted_text.dart';

/// Contains custom information about the user
class UserSupportInfo extends TdObject {
  String get tdType => 'userSupportInfo';

  /// Information message
  FormattedText? message;

  /// Information author
  string? author;

  /// Information change date
  int32? date;

  UserSupportInfo({
    super.extra,
    super.client_id,
    this.message,
    this.author,
    this.date,
  });

  UserSupportInfo.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['message'] != null) {
      message = TdApiMap.fromMap(map['message']) as FormattedText;
    }
    author = map['author'];
    date = map['date'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'message': message?.toMap(skipNulls: skipNulls),
      'author': author?.toMap(skipNulls: skipNulls),
      'date': date?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
