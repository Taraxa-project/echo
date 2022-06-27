import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/personal_details.dart';
import 'package:td_json_client/api/object/input_identity_document.dart';
import 'package:td_json_client/api/object/address.dart';
import 'package:td_json_client/api/object/input_personal_document.dart';

abstract class InputPassportElement extends TdObject {}

class InputPassportElementPersonalDetails extends InputPassportElement {
  String get tdType => 'inputPassportElementPersonalDetails';

  string? extra;
  int? client_id;
  PersonalDetails? personal_details;

  InputPassportElementPersonalDetails({
    this.extra,
    this.client_id,
    this.personal_details,
  });

  InputPassportElementPersonalDetails.fromMap(Map<String, dynamic> map) {
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
class InputPassportElementPassport extends InputPassportElement {
  String get tdType => 'inputPassportElementPassport';

  string? extra;
  int? client_id;
  InputIdentityDocument? passport;

  InputPassportElementPassport({
    this.extra,
    this.client_id,
    this.passport,
  });

  InputPassportElementPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    passport = TdApiMap.fromMap(map['passport']) as InputIdentityDocument;
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
class InputPassportElementDriverLicense extends InputPassportElement {
  String get tdType => 'inputPassportElementDriverLicense';

  string? extra;
  int? client_id;
  InputIdentityDocument? driver_license;

  InputPassportElementDriverLicense({
    this.extra,
    this.client_id,
    this.driver_license,
  });

  InputPassportElementDriverLicense.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    driver_license = TdApiMap.fromMap(map['driver_license']) as InputIdentityDocument;
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
class InputPassportElementIdentityCard extends InputPassportElement {
  String get tdType => 'inputPassportElementIdentityCard';

  string? extra;
  int? client_id;
  InputIdentityDocument? identity_card;

  InputPassportElementIdentityCard({
    this.extra,
    this.client_id,
    this.identity_card,
  });

  InputPassportElementIdentityCard.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    identity_card = TdApiMap.fromMap(map['identity_card']) as InputIdentityDocument;
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
class InputPassportElementInternalPassport extends InputPassportElement {
  String get tdType => 'inputPassportElementInternalPassport';

  string? extra;
  int? client_id;
  InputIdentityDocument? internal_passport;

  InputPassportElementInternalPassport({
    this.extra,
    this.client_id,
    this.internal_passport,
  });

  InputPassportElementInternalPassport.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    internal_passport = TdApiMap.fromMap(map['internal_passport']) as InputIdentityDocument;
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
class InputPassportElementAddress extends InputPassportElement {
  String get tdType => 'inputPassportElementAddress';

  string? extra;
  int? client_id;
  Address? address;

  InputPassportElementAddress({
    this.extra,
    this.client_id,
    this.address,
  });

  InputPassportElementAddress.fromMap(Map<String, dynamic> map) {
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
class InputPassportElementUtilityBill extends InputPassportElement {
  String get tdType => 'inputPassportElementUtilityBill';

  string? extra;
  int? client_id;
  InputPersonalDocument? utility_bill;

  InputPassportElementUtilityBill({
    this.extra,
    this.client_id,
    this.utility_bill,
  });

  InputPassportElementUtilityBill.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    utility_bill = TdApiMap.fromMap(map['utility_bill']) as InputPersonalDocument;
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
class InputPassportElementBankStatement extends InputPassportElement {
  String get tdType => 'inputPassportElementBankStatement';

  string? extra;
  int? client_id;
  InputPersonalDocument? bank_statement;

  InputPassportElementBankStatement({
    this.extra,
    this.client_id,
    this.bank_statement,
  });

  InputPassportElementBankStatement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    bank_statement = TdApiMap.fromMap(map['bank_statement']) as InputPersonalDocument;
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
class InputPassportElementRentalAgreement extends InputPassportElement {
  String get tdType => 'inputPassportElementRentalAgreement';

  string? extra;
  int? client_id;
  InputPersonalDocument? rental_agreement;

  InputPassportElementRentalAgreement({
    this.extra,
    this.client_id,
    this.rental_agreement,
  });

  InputPassportElementRentalAgreement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    rental_agreement = TdApiMap.fromMap(map['rental_agreement']) as InputPersonalDocument;
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
class InputPassportElementPassportRegistration extends InputPassportElement {
  String get tdType => 'inputPassportElementPassportRegistration';

  string? extra;
  int? client_id;
  InputPersonalDocument? passport_registration;

  InputPassportElementPassportRegistration({
    this.extra,
    this.client_id,
    this.passport_registration,
  });

  InputPassportElementPassportRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    passport_registration = TdApiMap.fromMap(map['passport_registration']) as InputPersonalDocument;
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
class InputPassportElementTemporaryRegistration extends InputPassportElement {
  String get tdType => 'inputPassportElementTemporaryRegistration';

  string? extra;
  int? client_id;
  InputPersonalDocument? temporary_registration;

  InputPassportElementTemporaryRegistration({
    this.extra,
    this.client_id,
    this.temporary_registration,
  });

  InputPassportElementTemporaryRegistration.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    temporary_registration = TdApiMap.fromMap(map['temporary_registration']) as InputPersonalDocument;
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
class InputPassportElementPhoneNumber extends InputPassportElement {
  String get tdType => 'inputPassportElementPhoneNumber';

  string? extra;
  int? client_id;
  string? phone_number;

  InputPassportElementPhoneNumber({
    this.extra,
    this.client_id,
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
class InputPassportElementEmailAddress extends InputPassportElement {
  String get tdType => 'inputPassportElementEmailAddress';

  string? extra;
  int? client_id;
  string? email_address;

  InputPassportElementEmailAddress({
    this.extra,
    this.client_id,
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
