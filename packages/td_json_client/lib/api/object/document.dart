import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/minithumbnail.dart';
import 'package:td_json_client/api/object/thumbnail.dart';
import 'package:td_json_client/api/object/file.dart';


/// Describes a document of any type 
class Document extends TdObject {
  String get tdType => 'document';

  String? extra;
  int? client_id;

  /// Original name of the file; as defined by the sender 
  string? file_name;

  /// MIME type of the file; as defined by the sender
  string? mime_type;

  /// Document minithumbnail; may be null 
  Minithumbnail? minithumbnail;

  /// Document thumbnail in JPEG or PNG format (PNG will be used only for background patterns); as defined by the sender; may be null 
  Thumbnail? thumbnail;

  /// File containing the document
  File? document;

  Document({
    this.extra,
    this.client_id,
    this.file_name,
    this.mime_type,
    this.minithumbnail,
    this.thumbnail,
    this.document,
  });

  Document.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    file_name = map['file_name'];
    mime_type = map['mime_type'];
    minithumbnail = TdApiMap.fromMap(map['minithumbnail']) as Minithumbnail;
    thumbnail = TdApiMap.fromMap(map['thumbnail']) as Thumbnail;
    document = TdApiMap.fromMap(map['document']) as File;
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'file_name': file_name?.toMap(skipNulls: skipNulls),
      'mime_type': mime_type?.toMap(skipNulls: skipNulls),
      'minithumbnail': minithumbnail?.toMap(skipNulls: skipNulls),
      'thumbnail': thumbnail?.toMap(skipNulls: skipNulls),
      'document': document?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
