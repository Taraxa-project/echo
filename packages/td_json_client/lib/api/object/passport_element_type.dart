import 'package:td_json_client/api/base.dart';

/// Contains the type of a Telegram Passport element
abstract class PassportElementType extends TdObject {
  PassportElementType({super.extra, super.client_id});
}


/// A Telegram Passport element containing the user's personal details
class PassportElementTypePersonalDetails extends PassportElementType {
  String get tdType => 'passportElementTypePersonalDetails';


  PassportElementTypePersonalDetails({
    super.extra,
    super.client_id,
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


  PassportElementTypePassport({
    super.extra,
    super.client_id,
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


  PassportElementTypeDriverLicense({
    super.extra,
    super.client_id,
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


  PassportElementTypeIdentityCard({
    super.extra,
    super.client_id,
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


  PassportElementTypeInternalPassport({
    super.extra,
    super.client_id,
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


  PassportElementTypeAddress({
    super.extra,
    super.client_id,
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


  PassportElementTypeUtilityBill({
    super.extra,
    super.client_id,
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


  PassportElementTypeBankStatement({
    super.extra,
    super.client_id,
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


  PassportElementTypeRentalAgreement({
    super.extra,
    super.client_id,
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


  PassportElementTypePassportRegistration({
    super.extra,
    super.client_id,
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


  PassportElementTypeTemporaryRegistration({
    super.extra,
    super.client_id,
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


  PassportElementTypePhoneNumber({
    super.extra,
    super.client_id,
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


  PassportElementTypeEmailAddress({
    super.extra,
    super.client_id,
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
