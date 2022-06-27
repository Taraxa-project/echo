import 'package:td_json_client/api/base.dart';

/// Describes the reason why a chat is reported
abstract class ChatReportReason extends TdObject {}


/// The chat contains spam messages
class ChatReportReasonSpam extends ChatReportReason {
  String get tdType => 'chatReportReasonSpam';

  String? extra;
  int? client_id;

  ChatReportReasonSpam({
    this.extra,
    this.client_id,
  });

  ChatReportReasonSpam.fromMap(Map<String, dynamic> map) {
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

/// The chat promotes violence
class ChatReportReasonViolence extends ChatReportReason {
  String get tdType => 'chatReportReasonViolence';

  String? extra;
  int? client_id;

  ChatReportReasonViolence({
    this.extra,
    this.client_id,
  });

  ChatReportReasonViolence.fromMap(Map<String, dynamic> map) {
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

/// The chat contains pornographic messages
class ChatReportReasonPornography extends ChatReportReason {
  String get tdType => 'chatReportReasonPornography';

  String? extra;
  int? client_id;

  ChatReportReasonPornography({
    this.extra,
    this.client_id,
  });

  ChatReportReasonPornography.fromMap(Map<String, dynamic> map) {
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

/// The chat has child abuse related content
class ChatReportReasonChildAbuse extends ChatReportReason {
  String get tdType => 'chatReportReasonChildAbuse';

  String? extra;
  int? client_id;

  ChatReportReasonChildAbuse({
    this.extra,
    this.client_id,
  });

  ChatReportReasonChildAbuse.fromMap(Map<String, dynamic> map) {
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

/// The chat contains copyrighted content
class ChatReportReasonCopyright extends ChatReportReason {
  String get tdType => 'chatReportReasonCopyright';

  String? extra;
  int? client_id;

  ChatReportReasonCopyright({
    this.extra,
    this.client_id,
  });

  ChatReportReasonCopyright.fromMap(Map<String, dynamic> map) {
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

/// The location-based chat is unrelated to its stated location
class ChatReportReasonUnrelatedLocation extends ChatReportReason {
  String get tdType => 'chatReportReasonUnrelatedLocation';

  String? extra;
  int? client_id;

  ChatReportReasonUnrelatedLocation({
    this.extra,
    this.client_id,
  });

  ChatReportReasonUnrelatedLocation.fromMap(Map<String, dynamic> map) {
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

/// The chat represents a fake account
class ChatReportReasonFake extends ChatReportReason {
  String get tdType => 'chatReportReasonFake';

  String? extra;
  int? client_id;

  ChatReportReasonFake({
    this.extra,
    this.client_id,
  });

  ChatReportReasonFake.fromMap(Map<String, dynamic> map) {
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

/// The chat has illegal drugs related content
class ChatReportReasonIllegalDrugs extends ChatReportReason {
  String get tdType => 'chatReportReasonIllegalDrugs';

  String? extra;
  int? client_id;

  ChatReportReasonIllegalDrugs({
    this.extra,
    this.client_id,
  });

  ChatReportReasonIllegalDrugs.fromMap(Map<String, dynamic> map) {
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

/// The chat contains messages with personal details
class ChatReportReasonPersonalDetails extends ChatReportReason {
  String get tdType => 'chatReportReasonPersonalDetails';

  String? extra;
  int? client_id;

  ChatReportReasonPersonalDetails({
    this.extra,
    this.client_id,
  });

  ChatReportReasonPersonalDetails.fromMap(Map<String, dynamic> map) {
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

/// A custom reason provided by the user
class ChatReportReasonCustom extends ChatReportReason {
  String get tdType => 'chatReportReasonCustom';

  String? extra;
  int? client_id;

  ChatReportReasonCustom({
    this.extra,
    this.client_id,
  });

  ChatReportReasonCustom.fromMap(Map<String, dynamic> map) {
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
