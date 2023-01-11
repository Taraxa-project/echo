import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';
import 'package:td_json_client/api/object/dated_file.dart';


/// Contains information about an encrypted Telegram Passport element; for bots only
class EncryptedPassportElement extends TdObject {
  String get tdType => 'encryptedPassportElement';


  /// Type of Telegram Passport element
  PassportElementType? type;

  /// Encrypted JSON-encoded data about the user
  bytes? data;

  /// The front side of an identity document
  DatedFile? front_side;

  /// The reverse side of an identity document; may be null
  DatedFile? reverse_side;

  /// Selfie with the document; may be null
  DatedFile? selfie;

  /// List of files containing a certified English translation of the document
  vector<DatedFile>? translation;

  /// List of attached files
  vector<DatedFile>? files;

  /// Unencrypted data, phone number or email address
  string? value;

  /// Hash of the entire element
  string? hash;

  EncryptedPassportElement({
    super.extra,
    super.client_id,
    this.type,
    this.data,
    this.front_side,
    this.reverse_side,
    this.selfie,
    this.translation,
    this.files,
    this.value,
    this.hash,
  });

  EncryptedPassportElement.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    if (map['type'] != null) {
      type = TdApiMap.fromMap(map['type']) as PassportElementType;
    }
    data = map['data'];
    if (map['front_side'] != null) {
      front_side = TdApiMap.fromMap(map['front_side']) as DatedFile;
    }
    if (map['reverse_side'] != null) {
      reverse_side = TdApiMap.fromMap(map['reverse_side']) as DatedFile;
    }
    if (map['selfie'] != null) {
      selfie = TdApiMap.fromMap(map['selfie']) as DatedFile;
    }
    if (map['translation'] != null) {
      translation = [];
      for (var someValue in map['translation']) {
        if (someValue != null) {
          translation?.add(TdApiMap.fromMap(someValue) as DatedFile);
        }
      }
    }
    if (map['files'] != null) {
      files = [];
      for (var someValue in map['files']) {
        if (someValue != null) {
          files?.add(TdApiMap.fromMap(someValue) as DatedFile);
        }
      }
    }
    value = map['value'];
    hash = map['hash'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'type': type?.toMap(skipNulls: skipNulls),
      'data': data?.toMap(skipNulls: skipNulls),
      'front_side': front_side?.toMap(skipNulls: skipNulls),
      'reverse_side': reverse_side?.toMap(skipNulls: skipNulls),
      'selfie': selfie?.toMap(skipNulls: skipNulls),
      'translation': translation?.toMap(skipNulls: skipNulls),
      'files': files?.toMap(skipNulls: skipNulls),
      'value': value?.toMap(skipNulls: skipNulls),
      'hash': hash?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
