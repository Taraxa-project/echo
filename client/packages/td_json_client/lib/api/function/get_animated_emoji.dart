import 'package:td_json_client/api/base.dart';


/// Returns an animated emoji corresponding to a given emoji. Returns a 404 error if the emoji has no animated emoji 
class GetAnimatedEmoji extends TdFunction {
  String get tdType => 'getAnimatedEmoji';
  String get tdReturnType => 'AnimatedEmoji';


  /// The emoji
  string? emoji;

  GetAnimatedEmoji({
    super.extra,
    super.client_id,
    this.emoji,
  });

  GetAnimatedEmoji.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    emoji = map['emoji'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'emoji': emoji?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
