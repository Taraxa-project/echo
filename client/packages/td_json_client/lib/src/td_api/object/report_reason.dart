import 'package:td_json_client/src/td_api/td.dart';

/// Describes the reason why a chat is reported
abstract class ReportReason extends TdObject {
  ReportReason({super.extra, super.client_id});
}

/// The chat contains spam messages
class ReportReasonSpam extends ReportReason {
  String get tdType => 'reportReasonSpam';

  ReportReasonSpam({
    super.extra,
    super.client_id,
  });

  ReportReasonSpam.fromMap(Map<String, dynamic> map) {
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
class ReportReasonViolence extends ReportReason {
  String get tdType => 'reportReasonViolence';

  ReportReasonViolence({
    super.extra,
    super.client_id,
  });

  ReportReasonViolence.fromMap(Map<String, dynamic> map) {
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
class ReportReasonPornography extends ReportReason {
  String get tdType => 'reportReasonPornography';

  ReportReasonPornography({
    super.extra,
    super.client_id,
  });

  ReportReasonPornography.fromMap(Map<String, dynamic> map) {
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
class ReportReasonChildAbuse extends ReportReason {
  String get tdType => 'reportReasonChildAbuse';

  ReportReasonChildAbuse({
    super.extra,
    super.client_id,
  });

  ReportReasonChildAbuse.fromMap(Map<String, dynamic> map) {
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
class ReportReasonCopyright extends ReportReason {
  String get tdType => 'reportReasonCopyright';

  ReportReasonCopyright({
    super.extra,
    super.client_id,
  });

  ReportReasonCopyright.fromMap(Map<String, dynamic> map) {
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
class ReportReasonUnrelatedLocation extends ReportReason {
  String get tdType => 'reportReasonUnrelatedLocation';

  ReportReasonUnrelatedLocation({
    super.extra,
    super.client_id,
  });

  ReportReasonUnrelatedLocation.fromMap(Map<String, dynamic> map) {
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
class ReportReasonFake extends ReportReason {
  String get tdType => 'reportReasonFake';

  ReportReasonFake({
    super.extra,
    super.client_id,
  });

  ReportReasonFake.fromMap(Map<String, dynamic> map) {
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
class ReportReasonIllegalDrugs extends ReportReason {
  String get tdType => 'reportReasonIllegalDrugs';

  ReportReasonIllegalDrugs({
    super.extra,
    super.client_id,
  });

  ReportReasonIllegalDrugs.fromMap(Map<String, dynamic> map) {
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
class ReportReasonPersonalDetails extends ReportReason {
  String get tdType => 'reportReasonPersonalDetails';

  ReportReasonPersonalDetails({
    super.extra,
    super.client_id,
  });

  ReportReasonPersonalDetails.fromMap(Map<String, dynamic> map) {
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
class ReportReasonCustom extends ReportReason {
  String get tdType => 'reportReasonCustom';

  ReportReasonCustom({
    super.extra,
    super.client_id,
  });

  ReportReasonCustom.fromMap(Map<String, dynamic> map) {
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
