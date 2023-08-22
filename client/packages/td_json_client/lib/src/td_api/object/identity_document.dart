import 'package:td_json_client/src/td_api/td.dart';
import 'package:td_json_client/src/td_api/td_api_map.dart';
import 'package:td_json_client/src/td_api/object/date.dart';
import 'package:td_json_client/src/td_api/object/dated_file.dart';

/// An identity document
class IdentityDocument extends TdObject {
  String get tdType => 'identityDocument';

  /// Document number; 1-24 characters
  string? number;

  /// Document expiration date; may be null if not applicable
  Date? expiration_date;

  /// Front side of the document
  DatedFile? front_side;

  /// Reverse side of the document; only for driver license and identity card; may be null
  DatedFile? reverse_side;

  /// Selfie with the document; may be null
  DatedFile? selfie;

  /// List of files containing a certified English translation of the document
  vector<DatedFile>? translation;

  IdentityDocument({
    super.extra,
    super.client_id,
    this.number,
    this.expiration_date,
    this.front_side,
    this.reverse_side,
    this.selfie,
    this.translation,
  });

  IdentityDocument.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    number = map['number'];
    if (map['expiration_date'] != null) {
      expiration_date = TdApiMap.fromMap(map['expiration_date']) as Date;
    }
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
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'number': number?.toMap(skipNulls: skipNulls),
      'expiration_date': expiration_date?.toMap(skipNulls: skipNulls),
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
