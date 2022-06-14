import 'dart:io' as io;

int getApiId() {
  String api_id = io.Platform.environment['API_ID'] ?? '0';
  return int.parse(api_id);
}

String getApiHash() {
  return io.Platform.environment['API_HASH'] ?? '';
}

String getPhoneNumber() {
  return io.Platform.environment['PHONE_NUMBER'] ?? '';
}
