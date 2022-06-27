import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/personal_details.dart';
import 'package:td_json_client/api/object/identity_document.dart';
import 'package:td_json_client/api/object/address.dart';
import 'package:td_json_client/api/object/personal_document.dart';

abstract class PassportElement extends TdObject {}

class PassportElementPersonalDetails extends PassportElement {
  String get tdType => 'passportElementPersonalDetails';

  string? extra;
  int? client_id;
  PersonalDetails? personal_details;

  PassportElementPersonalDetails({
    this.extra,
    this.client_id,
    this.personal_details,
  });

  PassportElementPersonalDetails.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    personal_details = TdApiMap.fromMap(map['personal_details']) as PersonalDetails;
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
class PassportElementPassport extends PassportElement {
  String get tdType => 'passportElementPassport';

  string? extra;
  int? client_id;
  IdentityDocument? passport;

  PassportElementPassport({
    this.extra,
    this.client_id,
    this.passport,
  });

  PassportElementPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    passport = TdApiMap.fromMap(map['passport']) as IdentityDocument;
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
class PassportElementDriverLicense extends PassportElement {
  String get tdType => 'passportElementDriverLicense';

  string? extra;
  int? client_id;
  IdentityDocument? driver_license;

  PassportElementDriverLicense({
    this.extra,
    this.client_id,
    this.driver_license,
  });

  PassportElementDriverLicense.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    driver_license = TdApiMap.fromMap(map['driver_license']) as IdentityDocument;
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
class PassportElementIdentityCard extends PassportElement {
  String get tdType => 'passportElementIdentityCard';

  string? extra;
  int? client_id;
  IdentityDocument? identity_card;

  PassportElementIdentityCard({
    this.extra,
    this.client_id,
    this.identity_card,
  });

  PassportElementIdentityCard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    identity_card = TdApiMap.fromMap(map['identity_card']) as IdentityDocument;
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
class PassportElementInternalPassport extends PassportElement {
  String get tdType => 'passportElementInternalPassport';

  string? extra;
  int? client_id;
  IdentityDocument? internal_passport;

  PassportElementInternalPassport({
    this.extra,
    this.client_id,
    this.internal_passport,
  });

  PassportElementInternalPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    internal_passport = TdApiMap.fromMap(map['internal_passport']) as IdentityDocument;
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
class PassportElementAddress extends PassportElement {
  String get tdType => 'passportElementAddress';

  string? extra;
  int? client_id;
  Address? address;

  PassportElementAddress({
    this.extra,
    this.client_id,
    this.address,
  });

  PassportElementAddress.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    address = TdApiMap.fromMap(map['address']) as Address;
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
class PassportElementUtilityBill extends PassportElement {
  String get tdType => 'passportElementUtilityBill';

  string? extra;
  int? client_id;
  PersonalDocument? utility_bill;

  PassportElementUtilityBill({
    this.extra,
    this.client_id,
    this.utility_bill,
  });

  PassportElementUtilityBill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    utility_bill = TdApiMap.fromMap(map['utility_bill']) as PersonalDocument;
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
class PassportElementBankStatement extends PassportElement {
  String get tdType => 'passportElementBankStatement';

  string? extra;
  int? client_id;
  PersonalDocument? bank_statement;

  PassportElementBankStatement({
    this.extra,
    this.client_id,
    this.bank_statement,
  });

  PassportElementBankStatement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bank_statement = TdApiMap.fromMap(map['bank_statement']) as PersonalDocument;
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
class PassportElementRentalAgreement extends PassportElement {
  String get tdType => 'passportElementRentalAgreement';

  string? extra;
  int? client_id;
  PersonalDocument? rental_agreement;

  PassportElementRentalAgreement({
    this.extra,
    this.client_id,
    this.rental_agreement,
  });

  PassportElementRentalAgreement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    rental_agreement = TdApiMap.fromMap(map['rental_agreement']) as PersonalDocument;
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
class PassportElementPassportRegistration extends PassportElement {
  String get tdType => 'passportElementPassportRegistration';

  string? extra;
  int? client_id;
  PersonalDocument? passport_registration;

  PassportElementPassportRegistration({
    this.extra,
    this.client_id,
    this.passport_registration,
  });

  PassportElementPassportRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    passport_registration = TdApiMap.fromMap(map['passport_registration']) as PersonalDocument;
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
class PassportElementTemporaryRegistration extends PassportElement {
  String get tdType => 'passportElementTemporaryRegistration';

  string? extra;
  int? client_id;
  PersonalDocument? temporary_registration;

  PassportElementTemporaryRegistration({
    this.extra,
    this.client_id,
    this.temporary_registration,
  });

  PassportElementTemporaryRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    temporary_registration = TdApiMap.fromMap(map['temporary_registration']) as PersonalDocument;
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
class PassportElementPhoneNumber extends PassportElement {
  String get tdType => 'passportElementPhoneNumber';

  string? extra;
  int? client_id;
  string? phone_number;

  PassportElementPhoneNumber({
    this.extra,
    this.client_id,
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
class PassportElementEmailAddress extends PassportElement {
  String get tdType => 'passportElementEmailAddress';

  string? extra;
  int? client_id;
  string? email_address;

  PassportElementEmailAddress({
    this.extra,
    this.client_id,
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
