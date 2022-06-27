import 'package:td_json_client/api/base.dart';

class GetAnimatedEmoji extends TdFunction {
  String get tdType => 'getAnimatedEmoji';
  String get tdReturnType => 'AnimatedEmoji';

  String? extra;
  int? client_id;
  string? emoji;

  GetAnimatedEmoji({
    this.extra,
    this.client_id,
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
