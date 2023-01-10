import 'package:td_json_client/api/base.dart';


/// Returns an existing chat corresponding to a known basic group 
class CreateBasicGroupChat extends TdFunction {
  String get tdType => 'createBasicGroupChat';
  String get tdReturnType => 'Chat';


  /// Basic group identifier 
  int53? basic_group_id;

  /// Pass true to create the chat without a network request. In this case all information about the chat except its type, title and photo can be incorrect
  Bool? force;

  CreateBasicGroupChat({
    super.extra,
    super.client_id,
    this.basic_group_id,
    this.force,
  });

  CreateBasicGroupChat.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    basic_group_id = map['basic_group_id'];
    force = map['force'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'basic_group_id': basic_group_id?.toMap(skipNulls: skipNulls),
      'force': force?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
