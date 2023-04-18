import 'package:td_json_client/src/td_api/td.dart';

/// Checks whether the current session can be used to transfer a chat ownership to another user
class CanTransferOwnership extends TdFunction {
  String get tdType => 'canTransferOwnership';
  String get tdReturnType => 'CanTransferOwnershipResult';

  CanTransferOwnership({
    super.extra,
    super.client_id,
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
