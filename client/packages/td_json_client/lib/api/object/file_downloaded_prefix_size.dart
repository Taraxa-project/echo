import 'package:td_json_client/api/base.dart';


/// Contains size of downloaded prefix of a file 
class FileDownloadedPrefixSize extends TdObject {
  String get tdType => 'fileDownloadedPrefixSize';


  /// The prefix size, in bytes
  int53? size;

  FileDownloadedPrefixSize({
    super.extra,
    super.client_id,
    this.size,
  });

  FileDownloadedPrefixSize.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    size = map['size'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'size': size?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
