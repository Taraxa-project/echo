import 'package:td_json_client/api/base.dart';

class TdlibParameters extends TdObject {
  String get tdType => 'tdlibParameters';

  string? extra;
  int? client_id;
  Bool? use_test_dc;
  string? database_directory;
  string? files_directory;
  Bool? use_file_database;
  Bool? use_chat_info_database;
  Bool? use_message_database;
  Bool? use_secret_chats;
  int32? api_id;
  string? api_hash;
  string? system_language_code;
  string? device_model;
  string? system_version;
  string? application_version;
  Bool? enable_storage_optimizer;
  Bool? ignore_file_names;

  TdlibParameters({
    this.extra,
    this.client_id,
    this.use_test_dc,
    this.database_directory,
    this.files_directory,
    this.use_file_database,
    this.use_chat_info_database,
    this.use_message_database,
    this.use_secret_chats,
    this.api_id,
    this.api_hash,
    this.system_language_code,
    this.device_model,
    this.system_version,
    this.application_version,
    this.enable_storage_optimizer,
    this.ignore_file_names,
  });

  TdlibParameters.fromMap(Map<String, dynamic> map) {
    extra = map['@extra'];
    client_id = map['@client_id'];
    use_test_dc = map['use_test_dc'];
    database_directory = map['database_directory'];
    files_directory = map['files_directory'];
    use_file_database = map['use_file_database'];
    use_chat_info_database = map['use_chat_info_database'];
    use_message_database = map['use_message_database'];
    use_secret_chats = map['use_secret_chats'];
    api_id = map['api_id'];
    api_hash = map['api_hash'];
    system_language_code = map['system_language_code'];
    device_model = map['device_model'];
    system_version = map['system_version'];
    application_version = map['application_version'];
    enable_storage_optimizer = map['enable_storage_optimizer'];
    ignore_file_names = map['ignore_file_names'];
  }

  Map<String, dynamic> toMap({skipNulls = true}) {
    Map<String, dynamic> map = {
      '@type': tdType,
      '@extra': extra?.toMap(skipNulls: skipNulls),
      '@client_id': client_id?.toMap(skipNulls: skipNulls),
      'use_test_dc': use_test_dc?.toMap(skipNulls: skipNulls),
      'database_directory': database_directory?.toMap(skipNulls: skipNulls),
      'files_directory': files_directory?.toMap(skipNulls: skipNulls),
      'use_file_database': use_file_database?.toMap(skipNulls: skipNulls),
      'use_chat_info_database': use_chat_info_database?.toMap(skipNulls: skipNulls),
      'use_message_database': use_message_database?.toMap(skipNulls: skipNulls),
      'use_secret_chats': use_secret_chats?.toMap(skipNulls: skipNulls),
      'api_id': api_id?.toMap(skipNulls: skipNulls),
      'api_hash': api_hash?.toMap(skipNulls: skipNulls),
      'system_language_code': system_language_code?.toMap(skipNulls: skipNulls),
      'device_model': device_model?.toMap(skipNulls: skipNulls),
      'system_version': system_version?.toMap(skipNulls: skipNulls),
      'application_version': application_version?.toMap(skipNulls: skipNulls),
      'enable_storage_optimizer': enable_storage_optimizer?.toMap(skipNulls: skipNulls),
      'ignore_file_names': ignore_file_names?.toMap(skipNulls: skipNulls),
    };
    if (skipNulls) {
      map.removeWhere((key, value) => value == null);
    }
    return map;
  }
}
