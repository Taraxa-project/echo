import 'package:td_json_client/api/base.dart';

/// Represents a remote file
class RemoteFile extends TdObject {
  String get tdType => 'remoteFile';

  /// Remote file identifier; may be empty. Can be used by the current user across application restarts or even from other devices. Uniquely identifies a file, but a file can have a lot of different valid identifiers.
  /// If the ID starts with "http://" or "https://", it represents the HTTP URL of the file. TDLib is currently unable to download files if only their URL is known.
  /// If downloadFile/addFileToDownloads is called on such a file or if it is sent to a secret chat, TDLib starts a file generation process by sending updateFileGenerationStart to the application with the HTTP URL in the original_path and "#url#" as the conversion string.
  /// Application must generate the file by downloading it to the specified location
  string? id;

  /// Unique file identifier; may be empty if unknown. The unique file identifier which is the same for the same file even for different users and is persistent over time
  string? unique_id;

  /// True, if the file is currently being uploaded (or a remote copy is being generated by some other means)
  Bool? is_uploading_active;

  /// True, if a remote copy is fully available
  Bool? is_uploading_completed;

  /// Size of the remote available part of the file, in bytes; 0 if unknown
  int53? uploaded_size;

  RemoteFile({
    super.extra,
    super.client_id,
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
      'is_uploading_completed':
          is_uploading_completed?.toMap(skipNulls: skipNulls),
      'uploaded_size': uploaded_size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
