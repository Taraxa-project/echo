import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/passport_element_type.dart';
import 'package:td_json_client/api/object/dated_file.dart';

class EncryptedPassportElement extends TdObject {
  String get tdType => 'encryptedPassportElement';

  string? extra;
  int? client_id;
  PassportElementType? type;
  bytes? data;
  DatedFile? front_side;
  DatedFile? reverse_side;
  DatedFile? selfie;
  vector<DatedFile>? translation;
  vector<DatedFile>? files;
  string? value;
  string? hash;

  EncryptedPassportElement({
    this.extra,
    this.client_id,
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
    type = TdApiMap.fromMap(map['type']) as PassportElementType;
    data = map['data'];
    front_side = TdApiMap.fromMap(map['front_side']) as DatedFile;
    reverse_side = TdApiMap.fromMap(map['reverse_side']) as DatedFile;
    selfie = TdApiMap.fromMap(map['selfie']) as DatedFile;
    if (map['translation']) {
      translation = [];
      for (var someValue in map['translation']) {
        translation?.add(TdApiMap.fromMap(someValue) as DatedFile);
      }
    }
    if (map['files']) {
      files = [];
      for (var someValue in map['files']) {
        files?.add(TdApiMap.fromMap(someValue) as DatedFile);
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
