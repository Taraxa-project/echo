import 'package:td_json_client/api/base.dart';


/// Contains parameters for TDLib initialization
class TdlibParameters extends TdObject {
  String get tdType => 'tdlibParameters';

  String? extra;
  int? client_id;

  /// If set to true, the Telegram test environment will be used instead of the production environment
  Bool? use_test_dc;

  /// The path to the directory for the persistent database; if empty, the current working directory will be used
  string? database_directory;

  /// The path to the directory for storing files; if empty, database_directory will be used
  string? files_directory;

  /// If set to true, information about downloaded and uploaded files will be saved between application restarts
  Bool? use_file_database;

  /// If set to true, the library will maintain a cache of users, basic groups, supergroups, channels and secret chats. Implies use_file_database
  Bool? use_chat_info_database;

  /// If set to true, the library will maintain a cache of chats and messages. Implies use_chat_info_database
  Bool? use_message_database;

  /// If set to true, support for secret chats will be enabled
  Bool? use_secret_chats;

  /// Application identifier for Telegram API access, which can be obtained at https://my.telegram.org
  int32? api_id;

  /// Application identifier hash for Telegram API access, which can be obtained at https://my.telegram.org
  string? api_hash;

  /// IETF language tag of the user's operating system language; must be non-empty
  string? system_language_code;

  /// Model of the device the application is being run on; must be non-empty
  string? device_model;

  /// Version of the operating system the application is being run on. If empty, the version is automatically detected by TDLib
  string? system_version;

  /// Application version; must be non-empty
  string? application_version;

  /// If set to true, old files will automatically be deleted
  Bool? enable_storage_optimizer;

  /// If set to true, original file names will be ignored. Otherwise, downloaded files will be saved under names as close as possible to the original name
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
