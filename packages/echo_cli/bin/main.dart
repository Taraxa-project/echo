import 'package:telegram_client/telegram_client.dart';
import 'package:echo_cli/telegram_config.dart' as telegram_config;

void main() {
  final telegramClient = TelegramClient();

  telegramClient.connect(telegram_config.getApiId(),
      telegram_config.getApiHash(), telegram_config.getPhoneNumber());

  telegramClient.disconnect();
}
