import 'package:td_json_client/api/base.dart';

abstract class CallProblem extends TdObject {}

class CallProblemEcho extends CallProblem {
  String get tdType => 'callProblemEcho';

  String? extra;
  int? client_id;

  CallProblemEcho({
    this.extra,
    this.client_id,
  });

  CallProblemEcho.fromMap(Map<String, dynamic> map) {
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
class CallProblemNoise extends CallProblem {
  String get tdType => 'callProblemNoise';

  String? extra;
  int? client_id;

  CallProblemNoise({
    this.extra,
    this.client_id,
  });

  CallProblemNoise.fromMap(Map<String, dynamic> map) {
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
class CallProblemInterruptions extends CallProblem {
  String get tdType => 'callProblemInterruptions';

  String? extra;
  int? client_id;

  CallProblemInterruptions({
    this.extra,
    this.client_id,
  });

  CallProblemInterruptions.fromMap(Map<String, dynamic> map) {
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
class CallProblemDistortedSpeech extends CallProblem {
  String get tdType => 'callProblemDistortedSpeech';

  String? extra;
  int? client_id;

  CallProblemDistortedSpeech({
    this.extra,
    this.client_id,
  });

  CallProblemDistortedSpeech.fromMap(Map<String, dynamic> map) {
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
class CallProblemSilentLocal extends CallProblem {
  String get tdType => 'callProblemSilentLocal';

  String? extra;
  int? client_id;

  CallProblemSilentLocal({
    this.extra,
    this.client_id,
  });

  CallProblemSilentLocal.fromMap(Map<String, dynamic> map) {
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
class CallProblemSilentRemote extends CallProblem {
  String get tdType => 'callProblemSilentRemote';

  String? extra;
  int? client_id;

  CallProblemSilentRemote({
    this.extra,
    this.client_id,
  });

  CallProblemSilentRemote.fromMap(Map<String, dynamic> map) {
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
class CallProblemDropped extends CallProblem {
  String get tdType => 'callProblemDropped';

  String? extra;
  int? client_id;

  CallProblemDropped({
    this.extra,
    this.client_id,
  });

  CallProblemDropped.fromMap(Map<String, dynamic> map) {
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
class CallProblemDistortedVideo extends CallProblem {
  String get tdType => 'callProblemDistortedVideo';

  String? extra;
  int? client_id;

  CallProblemDistortedVideo({
    this.extra,
    this.client_id,
  });

  CallProblemDistortedVideo.fromMap(Map<String, dynamic> map) {
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
class CallProblemPixelatedVideo extends CallProblem {
  String get tdType => 'callProblemPixelatedVideo';

  String? extra;
  int? client_id;

  CallProblemPixelatedVideo({
    this.extra,
    this.client_id,
  });

  CallProblemPixelatedVideo.fromMap(Map<String, dynamic> map) {
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
