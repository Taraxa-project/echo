import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/date.dart';
import 'package:td_json_client/api/object/dated_file.dart';

class IdentityDocument extends TdObject {
  String get tdType => 'identityDocument';

  string? extra;
  int? client_id;
  string? number;
  Date? expiry_date;
  DatedFile? front_side;
  DatedFile? reverse_side;
  DatedFile? selfie;
  vector<DatedFile>? translation;

  IdentityDocument({
    this.extra,
    this.client_id,
    this.number,
    this.expiry_date,
    this.front_side,
    this.reverse_side,
    this.selfie,
    this.translation,
  });

  IdentityDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    number = map['number'];
    expiry_date = TdApiMap.fromMap(map['expiry_date']) as Date;
    front_side = TdApiMap.fromMap(map['front_side']) as DatedFile;
    reverse_side = TdApiMap.fromMap(map['reverse_side']) as DatedFile;
    selfie = TdApiMap.fromMap(map['selfie']) as DatedFile;
    if (map['translation']) {
      translation = [];
      for (var someValue in map['translation']) {
        translation?.add(TdApiMap.fromMap(someValue) as DatedFile);
      }
    }
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'number': number?.toMap(skipNulls: skipNulls),
      'expiry_date': expiry_date?.toMap(skipNulls: skipNulls),
      'front_side': front_side?.toMap(skipNulls: skipNulls),
      'reverse_side': reverse_side?.toMap(skipNulls: skipNulls),
      'selfie': selfie?.toMap(skipNulls: skipNulls),
      'translation': translation?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
