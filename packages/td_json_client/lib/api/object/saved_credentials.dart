import 'package:td_json_client/api/base.dart';


/// Contains information about saved card credentials 
class SavedCredentials extends TdObject {
  String get tdType => 'savedCredentials';

  String? extra;
  int? client_id;

  /// Unique identifier of the saved credentials 
  string? id;

  /// Title of the saved credentials
  string? title;

  SavedCredentials({
    this.extra,
    this.client_id,
    this.id,
    this.title,
  });

  SavedCredentials.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    title = map['title'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'title': title?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
