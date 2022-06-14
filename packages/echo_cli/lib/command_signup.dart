import 'package:args/command_runner.dart';
import 'package:telegram_client/telegram_client.dart';

class CommandSignup extends Command {
  final name = 'signup';
  final description = 'Sign up a Telegram account.';

  void run() {
    final TelegramClient telegramClient = TelegramClient(
      globalResults!['libtdjson-path'],
      int.parse(globalResults!['api-id']),
      globalResults!['api-hash'],
      globalResults!['phone-number'],
    );
    telegramClient.signUp();
  }
}
