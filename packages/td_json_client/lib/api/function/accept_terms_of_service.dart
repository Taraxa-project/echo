import 'package:td_json_client/api/base.dart';

class AcceptTermsOfService extends TdFunction {
  String get tdType => 'acceptTermsOfService';
  String get tdReturnType => 'Ok';

  string? extra;
  int? client_id;
  string? terms_of_service_id;

  AcceptTermsOfService({
    this.extra,
    this.client_id,
    this.terms_of_service_id,
  });

  AcceptTermsOfService.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    terms_of_service_id = map['terms_of_service_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'terms_of_service_id': terms_of_service_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}