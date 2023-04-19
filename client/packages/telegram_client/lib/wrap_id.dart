class WrapId {
  static int messageIdMultiplier = 1048576; // 2 ^ 20

  static int unwrapChatId(int? id) {
    try {
      return int.parse(id.toString().replaceFirst('-100', ''));
    } on FormatException catch (ex) {
      throw UnWrapIdxception(id, ex.message);
    }
  }

  static int wrapChatId(int id) {
    return int.parse('-100' + id.toString());
  }

  static int unwrapMessageId(int? id) {
    if (id == null) {
      throw UnWrapIdxception(id);
    } else {
      return id ~/ WrapId.messageIdMultiplier;
    }
  }

  static int wrapMessageId(int id) {
    return id * WrapId.messageIdMultiplier;
  }
}

class UnWrapIdxception implements Exception {
  final int? id;
  final String? message;

  UnWrapIdxception([
    this.id = null,
    this.message = '',
  ]);

  String toString() {
    var report = "TgException: could not unwrap id $id";
    if (message != null) {
      report += ', $message';
    }
    return report;
  }
}
