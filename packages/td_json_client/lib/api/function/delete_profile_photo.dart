import 'package:td_json_client/api/base.dart';

class DeleteProfilePhoto extends TdFunction {
  String get tdType => 'deleteProfilePhoto';
  String get tdReturnType => 'Ok';

  String? extra;
  int? client_id;
  int64? profile_photo_id;

  DeleteProfilePhoto({
    this.extra,
    this.client_id,
    this.profile_photo_id,
  });

  DeleteProfilePhoto.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    profile_photo_id = map['profile_photo_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'profile_photo_id': profile_photo_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
