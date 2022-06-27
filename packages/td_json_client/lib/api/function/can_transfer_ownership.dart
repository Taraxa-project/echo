import 'package:td_json_client/api/base.dart';

class CanTransferOwnership extends TdFunction {
  String get tdType => 'canTransferOwnership';
  String get tdReturnType => 'CanTransferOwnershipResult';

  String? extra;
  int? client_id;

  CanTransferOwnership({
    this.extra,
    this.client_id,
  });

  CanTransferOwnership.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
