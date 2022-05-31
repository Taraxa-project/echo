# Documentation

#### Telegram Api Support user bot and bot
- Telegram
    - ```constuctor(String token, Map option)```
    default option
```dart
Map<String, dynamic> options = {
    "botPath": "/bot/",
    "userPath": "/user/",
    "port": 8080,
    "type": "bot", // replace user if you want login as user account
    "logger": false,
    "api": "https://api.telegram.org/" // replace if you want run bot on your local server or another server
};
```
- Request Raw Api
    - ```request("method", option)``` 
    request raw api is auto update from official server api,
    example request api:
```dart
var lib = Telegram("replace_token");
var tg = lib.api;
// chat id and text is required see docs for detail
Map parameters = {
    "chat_id":  132435,
    "text": "hello world"
};
tg.request("sendMessage", parameters);
```
- Request Short api
    - ```methodName(required, params)```
    request short api is not auto update because more method in server api
    example request sendMessage
```dart
var lib = Telegram("replace_token");
var tg = lib.api;
// chat id and text is required see docs for detail
tg.sendMessage(123456, "hewllo");
```

#### Telegram Database Library ( Tdlib )
- Support user bot and bot
- High Speed on low internet speed
- Support Mobile, Desktop, and Embedded System

##### Tdlib
- ```constuctor(pathFileTdlib, { options Map })```
    default option
    ```dart
    {
        'api_id': 0, // you must seet this to your own api id
        'api_hash': '', // and set this
        'database_directory': "", // and this
        'files_directory': "", // and this
        'enable_storage_optimizer': true,
        'system_language_code': 'en',
        'new_verbosity_level': 0,
        'application_version': 'v1',
        'device_model': 'dart',
        'system_version': 'azkadev',
        "database_key": "" 
    }
    ```
- ```on((update){   })```
    on update will listen update raw next update will set spesified like newMessage, messagegroup only etx

- Login
    Login in tdlib example
    Support ```bot``` and ```user``` Eg
    Bot
    ```dart
    var tdl = Tdlib("pathTdlib", {...option});
    tdl.clientSend({
        "@type": "checkAuthenticationBotToken",
        "token": "token_your_bot"
    });
    ```
    User
    ```dart
    var tdl = Tdlib("pathTdlib", {...option});
    tdl.clientSend({
        '@type': 'setAuthenticationPhoneNumber',
        'phone_number': '628516226262', //your phone
        'settings': {
            'allow_flash_call': false,
            'is_current_phone_number': false,
            'allow_sms_retriever_api': false
        }
    });
    ```

# Need More Efficiency and easy use?
Please Hire Me to your project or buy me a cup tea or milk hehe because i don't like coffe