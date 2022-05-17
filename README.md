# echo

Social Listen Application with Dart implementing Telegram's tdlib

## Dev

Install Dart SDK -> https://dart.dev/get-dart

Windows:

Use Chocolatey
```bash
choco install dart-sdk`
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
Create App:
```bash
dart create -t {template} {dir}
```

Start App:
```bash
cd {dir}
dart run
```
