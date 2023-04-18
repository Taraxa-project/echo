# echo

Social Listen Application with Dart implementing Telegram's tdlib

## Docker
```bash
docker-compose up --build
```

## Dev

Install Dart SDK -> https://dart.dev/get-dart

Windows:

Use Chocolatey
```bash
choco install dart-sdk
```


Linux:

One Time Setup:
```bash
sudo apt-get update
sudo apt-get install apt-transport-https
wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
```
Install SDK:
```bash
sudo apt-get update
sudo apt-get install dart
```

Mac: 
```bash
brew tap dart-lang/dart
brew install dart
```

Install dependencies:
```bash
dart pub get
```

Add env file and vars:
```bash
dart pub global activate dotenv
dart pub global run dotenv:new
printf 'API_ID=""\nAPI_HASH=""\nPHONE=""\nLIB_TD_JSON_PATH=""\n' >> .env
printf 'cp .env env.local'
```

Start App:
```bash
dart run packages/cli/bin/main.dart
```
