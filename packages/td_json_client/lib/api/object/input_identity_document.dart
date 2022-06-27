import 'package:td_json_client/api/base.dart';
import 'package:td_json_client/api/map.dart';
import 'package:td_json_client/api/object/date.dart';
import 'package:td_json_client/api/object/input_file.dart';

class InputIdentityDocument extends TdObject {
  String get tdType => 'inputIdentityDocument';

  String? extra;
  int? client_id;
  string? number;
  Date? expiry_date;
  InputFile? front_side;
  InputFile? reverse_side;
  InputFile? selfie;
  vector<InputFile>? translation;

  InputIdentityDocument({
    this.extra,
    this.client_id,
    this.number,
    this.expiry_date,
    this.front_side,
    this.reverse_side,
    this.selfie,
    this.translation,
  });

  InputIdentityDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    number = map['number'];
    expiry_date = TdApiMap.fromMap(map['expiry_date']) as Date;
    front_side = TdApiMap.fromMap(map['front_side']) as InputFile;
    reverse_side = TdApiMap.fromMap(map['reverse_side']) as InputFile;
    selfie = TdApiMap.fromMap(map['selfie']) as InputFile;
    if (map['translation']) {
      translation = [];
      for (var someValue in map['translation']) {
        translation?.add(TdApiMap.fromMap(someValue) as InputFile);
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
