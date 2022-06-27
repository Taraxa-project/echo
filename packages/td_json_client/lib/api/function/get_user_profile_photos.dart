import 'package:td_json_client/api/base.dart';


/// Returns the profile photos of a user. The result of this query may be outdated: some photos might have been deleted already 
class GetUserProfilePhotos extends TdFunction {
  String get tdType => 'getUserProfilePhotos';
  String get tdReturnType => 'ChatPhotos';

  String? extra;
  int? client_id;

  /// User identifier 
  int53? user_id;

  /// The number of photos to skip; must be non-negative 
  int32? offset;

  /// The maximum number of photos to be returned; up to 100
  int32? limit;

  GetUserProfilePhotos({
    this.extra,
    this.client_id,
    this.user_id,
    this.offset,
    this.limit,
  });

  GetUserProfilePhotos.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    user_id = map['user_id'];
    offset = map['offset'];
    limit = map['limit'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'user_id': user_id?.toMap(skipNulls: skipNulls),
      'offset': offset?.toMap(skipNulls: skipNulls),
      'limit': limit?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
