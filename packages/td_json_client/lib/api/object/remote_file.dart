import 'package:td_json_client/api/base.dart';

class RemoteFile extends TdObject {
  String get tdType => 'remoteFile';

  string? extra;
  int? client_id;
  string? id;
  string? unique_id;
  Bool? is_uploading_active;
  Bool? is_uploading_completed;
  int32? uploaded_size;

  RemoteFile({
    this.extra,
    this.client_id,
    this.id,
    this.unique_id,
    this.is_uploading_active,
    this.is_uploading_completed,
    this.uploaded_size,
  });

  RemoteFile.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    id = map['id'];
    unique_id = map['unique_id'];
    is_uploading_active = map['is_uploading_active'];
    is_uploading_completed = map['is_uploading_completed'];
    uploaded_size = map['uploaded_size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'id': id?.toMap(skipNulls: skipNulls),
      'unique_id': unique_id?.toMap(skipNulls: skipNulls),
      'is_uploading_active': is_uploading_active?.toMap(skipNulls: skipNulls),
      'is_uploading_completed': is_uploading_completed?.toMap(skipNulls: skipNulls),
      'uploaded_size': uploaded_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
