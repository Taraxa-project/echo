import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/personal_details.dart';
import 'package:td_json_client/src/td_api/object/input_identity_document.dart';
import 'package:td_json_client/src/td_api/object/address.dart';
import 'package:td_json_client/src/td_api/object/input_personal_document.dart';

/// Contains information about a Telegram Passport element to be saved
abstract class InputPassportElement extends TdObject {
  InputPassportElement({super.extra, super.client_id});
}

/// A Telegram Passport element to be saved containing the user's personal details
class InputPassportElementPersonalDetails extends InputPassportElement {
  String get tdType => 'inputPassportElementPersonalDetails';

  /// Personal details of the user
  PersonalDetails? personal_details;

  InputPassportElementPersonalDetails({
    super.extra,
    super.client_id,
    this.personal_details,
  });

  InputPassportElementPersonalDetails.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['personal_details'] != null) {
      personal_details = TdApiMap.fromMap(map['personal_details']) as PersonalDetails;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'personal_details': personal_details?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's passport
class InputPassportElementPassport extends InputPassportElement {
  String get tdType => 'inputPassportElementPassport';

  /// The passport to be saved
  InputIdentityDocument? passport;

  InputPassportElementPassport({
    super.extra,
    super.client_id,
    this.passport,
  });

  InputPassportElementPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['passport'] != null) {
      passport = TdApiMap.fromMap(map['passport']) as InputIdentityDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'passport': passport?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's driver license
class InputPassportElementDriverLicense extends InputPassportElement {
  String get tdType => 'inputPassportElementDriverLicense';

  /// The driver license to be saved
  InputIdentityDocument? driver_license;

  InputPassportElementDriverLicense({
    super.extra,
    super.client_id,
    this.driver_license,
  });

  InputPassportElementDriverLicense.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['driver_license'] != null) {
      driver_license = TdApiMap.fromMap(map['driver_license']) as InputIdentityDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'driver_license': driver_license?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's identity card
class InputPassportElementIdentityCard extends InputPassportElement {
  String get tdType => 'inputPassportElementIdentityCard';

  /// The identity card to be saved
  InputIdentityDocument? identity_card;

  InputPassportElementIdentityCard({
    super.extra,
    super.client_id,
    this.identity_card,
  });

  InputPassportElementIdentityCard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['identity_card'] != null) {
      identity_card = TdApiMap.fromMap(map['identity_card']) as InputIdentityDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'identity_card': identity_card?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's internal passport
class InputPassportElementInternalPassport extends InputPassportElement {
  String get tdType => 'inputPassportElementInternalPassport';

  /// The internal passport to be saved
  InputIdentityDocument? internal_passport;

  InputPassportElementInternalPassport({
    super.extra,
    super.client_id,
    this.internal_passport,
  });

  InputPassportElementInternalPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['internal_passport'] != null) {
      internal_passport = TdApiMap.fromMap(map['internal_passport']) as InputIdentityDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'internal_passport': internal_passport?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's address
class InputPassportElementAddress extends InputPassportElement {
  String get tdType => 'inputPassportElementAddress';

  /// The address to be saved
  Address? address;

  InputPassportElementAddress({
    super.extra,
    super.client_id,
    this.address,
  });

  InputPassportElementAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['address'] != null) {
      address = TdApiMap.fromMap(map['address']) as Address;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'address': address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's utility bill
class InputPassportElementUtilityBill extends InputPassportElement {
  String get tdType => 'inputPassportElementUtilityBill';

  /// The utility bill to be saved
  InputPersonalDocument? utility_bill;

  InputPassportElementUtilityBill({
    super.extra,
    super.client_id,
    this.utility_bill,
  });

  InputPassportElementUtilityBill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['utility_bill'] != null) {
      utility_bill = TdApiMap.fromMap(map['utility_bill']) as InputPersonalDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'utility_bill': utility_bill?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's bank statement
class InputPassportElementBankStatement extends InputPassportElement {
  String get tdType => 'inputPassportElementBankStatement';

  /// The bank statement to be saved
  InputPersonalDocument? bank_statement;

  InputPassportElementBankStatement({
    super.extra,
    super.client_id,
    this.bank_statement,
  });

  InputPassportElementBankStatement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['bank_statement'] != null) {
      bank_statement = TdApiMap.fromMap(map['bank_statement']) as InputPersonalDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'bank_statement': bank_statement?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's rental agreement
class InputPassportElementRentalAgreement extends InputPassportElement {
  String get tdType => 'inputPassportElementRentalAgreement';

  /// The rental agreement to be saved
  InputPersonalDocument? rental_agreement;

  InputPassportElementRentalAgreement({
    super.extra,
    super.client_id,
    this.rental_agreement,
  });

  InputPassportElementRentalAgreement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rental_agreement'] != null) {
      rental_agreement = TdApiMap.fromMap(map['rental_agreement']) as InputPersonalDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'rental_agreement': rental_agreement?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's passport registration
class InputPassportElementPassportRegistration extends InputPassportElement {
  String get tdType => 'inputPassportElementPassportRegistration';

  /// The passport registration page to be saved
  InputPersonalDocument? passport_registration;

  InputPassportElementPassportRegistration({
    super.extra,
    super.client_id,
    this.passport_registration,
  });

  InputPassportElementPassportRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['passport_registration'] != null) {
      passport_registration = TdApiMap.fromMap(map['passport_registration']) as InputPersonalDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'passport_registration': passport_registration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's temporary registration
class InputPassportElementTemporaryRegistration extends InputPassportElement {
  String get tdType => 'inputPassportElementTemporaryRegistration';

  /// The temporary registration document to be saved
  InputPersonalDocument? temporary_registration;

  InputPassportElementTemporaryRegistration({
    super.extra,
    super.client_id,
    this.temporary_registration,
  });

  InputPassportElementTemporaryRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['temporary_registration'] != null) {
      temporary_registration = TdApiMap.fromMap(map['temporary_registration']) as InputPersonalDocument;
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'temporary_registration': temporary_registration?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's phone number
class InputPassportElementPhoneNumber extends InputPassportElement {
  String get tdType => 'inputPassportElementPhoneNumber';

  /// The phone number to be saved
  string? phone_number;

  InputPassportElementPhoneNumber({
    super.extra,
    super.client_id,
    this.phone_number,
  });

  InputPassportElementPhoneNumber.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    phone_number = map['phone_number'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'phone_number': phone_number?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}

/// A Telegram Passport element to be saved containing the user's email address
class InputPassportElementEmailAddress extends InputPassportElement {
  String get tdType => 'inputPassportElementEmailAddress';

  /// The email address to be saved
  string? email_address;

  InputPassportElementEmailAddress({
    super.extra,
    super.client_id,
    this.email_address,
  });

  InputPassportElementEmailAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    email_address = map['email_address'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'email_address': email_address?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
