import 'package:td_json_client/api/base.dart';


/// Returns an existing chat corresponding to a known supergroup or channel 
class CreateSupergroupChat extends TdFunction {
  String get tdType => 'createSupergroupChat';
  String get tdReturnType => 'Chat';

  String? extra;
  int? client_id;

  /// Supergroup or channel identifier 
  int53? supergroup_id;

  /// If true, the chat will be created without network request. In this case all information about the chat except its type, title and photo can be incorrect
  Bool? force;

  CreateSupergroupChat({
    this.extra,
    this.client_id,
    this.supergroup_id,
    this.force,
  });

  CreateSupergroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    supergroup_id = map['supergroup_id'];
    force = map['force'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'supergroup_id': supergroup_id?.toMap(skipNulls: skipNulls),
      'force': force?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
