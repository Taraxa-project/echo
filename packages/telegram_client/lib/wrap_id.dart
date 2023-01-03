import 'dart:math';

class WrapId {
  static int messageIdMultiplier = 1048576; // 2 ^ 20

  static int? unwrapChatId(int? id) {
    return int.tryParse(id.toString().replaceFirst('-100', ''));
  }

  static int wrapChatId(int id) {
    return int.parse('-100' + id.toString());
  }

  static int? unwrapMessageId(int? id) {
    if (id == null) {
      return id;
    } else {
      return id ~/ WrapId.messageIdMultiplier;
    }
  }

  static int wrapMessageId(int id) {
    return id * WrapId.messageIdMultiplier;
  }
}
