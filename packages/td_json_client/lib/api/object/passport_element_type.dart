import 'package:td_json_client/api/base.dart';

/// Contains the type of a Telegram Passport element
abstract class PassportElementType extends TdObject {}


/// A Telegram Passport element containing the user's personal details
class PassportElementTypePersonalDetails extends PassportElementType {
  String get tdType => 'passportElementTypePersonalDetails';

  String? extra;
  int? client_id;

  PassportElementTypePersonalDetails({
    this.extra,
    this.client_id,
  });

  PassportElementTypePersonalDetails.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's passport
class PassportElementTypePassport extends PassportElementType {
  String get tdType => 'passportElementTypePassport';

  String? extra;
  int? client_id;

  PassportElementTypePassport({
    this.extra,
    this.client_id,
  });

  PassportElementTypePassport.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's driver license
class PassportElementTypeDriverLicense extends PassportElementType {
  String get tdType => 'passportElementTypeDriverLicense';

  String? extra;
  int? client_id;

  PassportElementTypeDriverLicense({
    this.extra,
    this.client_id,
  });

  PassportElementTypeDriverLicense.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's identity card
class PassportElementTypeIdentityCard extends PassportElementType {
  String get tdType => 'passportElementTypeIdentityCard';

  String? extra;
  int? client_id;

  PassportElementTypeIdentityCard({
    this.extra,
    this.client_id,
  });

  PassportElementTypeIdentityCard.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's internal passport
class PassportElementTypeInternalPassport extends PassportElementType {
  String get tdType => 'passportElementTypeInternalPassport';

  String? extra;
  int? client_id;

  PassportElementTypeInternalPassport({
    this.extra,
    this.client_id,
  });

  PassportElementTypeInternalPassport.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's address
class PassportElementTypeAddress extends PassportElementType {
  String get tdType => 'passportElementTypeAddress';

  String? extra;
  int? client_id;

  PassportElementTypeAddress({
    this.extra,
    this.client_id,
  });

  PassportElementTypeAddress.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's utility bill
class PassportElementTypeUtilityBill extends PassportElementType {
  String get tdType => 'passportElementTypeUtilityBill';

  String? extra;
  int? client_id;

  PassportElementTypeUtilityBill({
    this.extra,
    this.client_id,
  });

  PassportElementTypeUtilityBill.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's bank statement
class PassportElementTypeBankStatement extends PassportElementType {
  String get tdType => 'passportElementTypeBankStatement';

  String? extra;
  int? client_id;

  PassportElementTypeBankStatement({
    this.extra,
    this.client_id,
  });

  PassportElementTypeBankStatement.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's rental agreement
class PassportElementTypeRentalAgreement extends PassportElementType {
  String get tdType => 'passportElementTypeRentalAgreement';

  String? extra;
  int? client_id;

  PassportElementTypeRentalAgreement({
    this.extra,
    this.client_id,
  });

  PassportElementTypeRentalAgreement.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the registration page of the user's passport
class PassportElementTypePassportRegistration extends PassportElementType {
  String get tdType => 'passportElementTypePassportRegistration';

  String? extra;
  int? client_id;

  PassportElementTypePassportRegistration({
    this.extra,
    this.client_id,
  });

  PassportElementTypePassportRegistration.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's temporary registration
class PassportElementTypeTemporaryRegistration extends PassportElementType {
  String get tdType => 'passportElementTypeTemporaryRegistration';

  String? extra;
  int? client_id;

  PassportElementTypeTemporaryRegistration({
    this.extra,
    this.client_id,
  });

  PassportElementTypeTemporaryRegistration.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's phone number
class PassportElementTypePhoneNumber extends PassportElementType {
  String get tdType => 'passportElementTypePhoneNumber';

  String? extra;
  int? client_id;

  PassportElementTypePhoneNumber({
    this.extra,
    this.client_id,
  });

  PassportElementTypePhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's email address
class PassportElementTypeEmailAddress extends PassportElementType {
  String get tdType => 'passportElementTypeEmailAddress';

  String? extra;
  int? client_id;

  PassportElementTypeEmailAddress({
    this.extra,
    this.client_id,
  });

  PassportElementTypeEmailAddress.fromMap(Map<String, dynamic> map) {
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
