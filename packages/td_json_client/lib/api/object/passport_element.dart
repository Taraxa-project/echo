import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/personal_details.dart';
import 'package:td_json_client/api/object/identity_document.dart';
import 'package:td_json_client/api/object/address.dart';
import 'package:td_json_client/api/object/personal_document.dart';

/// Contains information about a Telegram Passport element
abstract class PassportElement extends TdObject {
  PassportElement({super.extra, super.client_id});
}


/// A Telegram Passport element containing the user's personal details 
class PassportElementPersonalDetails extends PassportElement {
  String get tdType => 'passportElementPersonalDetails';


  /// Personal details of the user
  PersonalDetails? personal_details;

  PassportElementPersonalDetails({
    super.extra,
    super.client_id,
    this.personal_details,
  });

  PassportElementPersonalDetails.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's passport 
class PassportElementPassport extends PassportElement {
  String get tdType => 'passportElementPassport';


  /// Passport
  IdentityDocument? passport;

  PassportElementPassport({
    super.extra,
    super.client_id,
    this.passport,
  });

  PassportElementPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['passport'] != null) {
      passport = TdApiMap.fromMap(map['passport']) as IdentityDocument;
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

/// A Telegram Passport element containing the user's driver license 
class PassportElementDriverLicense extends PassportElement {
  String get tdType => 'passportElementDriverLicense';


  /// Driver license
  IdentityDocument? driver_license;

  PassportElementDriverLicense({
    super.extra,
    super.client_id,
    this.driver_license,
  });

  PassportElementDriverLicense.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['driver_license'] != null) {
      driver_license = TdApiMap.fromMap(map['driver_license']) as IdentityDocument;
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

/// A Telegram Passport element containing the user's identity card 
class PassportElementIdentityCard extends PassportElement {
  String get tdType => 'passportElementIdentityCard';


  /// Identity card
  IdentityDocument? identity_card;

  PassportElementIdentityCard({
    super.extra,
    super.client_id,
    this.identity_card,
  });

  PassportElementIdentityCard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['identity_card'] != null) {
      identity_card = TdApiMap.fromMap(map['identity_card']) as IdentityDocument;
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

/// A Telegram Passport element containing the user's internal passport 
class PassportElementInternalPassport extends PassportElement {
  String get tdType => 'passportElementInternalPassport';


  /// Internal passport
  IdentityDocument? internal_passport;

  PassportElementInternalPassport({
    super.extra,
    super.client_id,
    this.internal_passport,
  });

  PassportElementInternalPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['internal_passport'] != null) {
      internal_passport = TdApiMap.fromMap(map['internal_passport']) as IdentityDocument;
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

/// A Telegram Passport element containing the user's address 
class PassportElementAddress extends PassportElement {
  String get tdType => 'passportElementAddress';


  /// Address
  Address? address;

  PassportElementAddress({
    super.extra,
    super.client_id,
    this.address,
  });

  PassportElementAddress.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's utility bill 
class PassportElementUtilityBill extends PassportElement {
  String get tdType => 'passportElementUtilityBill';


  /// Utility bill
  PersonalDocument? utility_bill;

  PassportElementUtilityBill({
    super.extra,
    super.client_id,
    this.utility_bill,
  });

  PassportElementUtilityBill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['utility_bill'] != null) {
      utility_bill = TdApiMap.fromMap(map['utility_bill']) as PersonalDocument;
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

/// A Telegram Passport element containing the user's bank statement 
class PassportElementBankStatement extends PassportElement {
  String get tdType => 'passportElementBankStatement';


  /// Bank statement
  PersonalDocument? bank_statement;

  PassportElementBankStatement({
    super.extra,
    super.client_id,
    this.bank_statement,
  });

  PassportElementBankStatement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['bank_statement'] != null) {
      bank_statement = TdApiMap.fromMap(map['bank_statement']) as PersonalDocument;
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

/// A Telegram Passport element containing the user's rental agreement 
class PassportElementRentalAgreement extends PassportElement {
  String get tdType => 'passportElementRentalAgreement';


  /// Rental agreement
  PersonalDocument? rental_agreement;

  PassportElementRentalAgreement({
    super.extra,
    super.client_id,
    this.rental_agreement,
  });

  PassportElementRentalAgreement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['rental_agreement'] != null) {
      rental_agreement = TdApiMap.fromMap(map['rental_agreement']) as PersonalDocument;
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

/// A Telegram Passport element containing the user's passport registration pages 
class PassportElementPassportRegistration extends PassportElement {
  String get tdType => 'passportElementPassportRegistration';


  /// Passport registration pages
  PersonalDocument? passport_registration;

  PassportElementPassportRegistration({
    super.extra,
    super.client_id,
    this.passport_registration,
  });

  PassportElementPassportRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['passport_registration'] != null) {
      passport_registration = TdApiMap.fromMap(map['passport_registration']) as PersonalDocument;
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

/// A Telegram Passport element containing the user's temporary registration 
class PassportElementTemporaryRegistration extends PassportElement {
  String get tdType => 'passportElementTemporaryRegistration';


  /// Temporary registration
  PersonalDocument? temporary_registration;

  PassportElementTemporaryRegistration({
    super.extra,
    super.client_id,
    this.temporary_registration,
  });

  PassportElementTemporaryRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['temporary_registration'] != null) {
      temporary_registration = TdApiMap.fromMap(map['temporary_registration']) as PersonalDocument;
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

/// A Telegram Passport element containing the user's phone number 
class PassportElementPhoneNumber extends PassportElement {
  String get tdType => 'passportElementPhoneNumber';


  /// Phone number
  string? phone_number;

  PassportElementPhoneNumber({
    super.extra,
    super.client_id,
    this.phone_number,
  });

  PassportElementPhoneNumber.fromMap(Map<String, dynamic> map) {
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

/// A Telegram Passport element containing the user's email address 
class PassportElementEmailAddress extends PassportElement {
  String get tdType => 'passportElementEmailAddress';


  /// Email address
  string? email_address;

  PassportElementEmailAddress({
    super.extra,
    super.client_id,
    this.email_address,
  });

  PassportElementEmailAddress.fromMap(Map<String, dynamic> map) {
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
