# flutter_tky

A Flutter plugin of talk_cloud sdk.

### 进入教室

```dart
FlutterTky.joinRoom(TkyRoomObj.fromJson(<String, dynamic>{
    'serial': 'xxxxx',//serial
    'userrole': '2',
    'host': '/global.talk-cloud.net',
    'server': 'global',
    'port': '443',
    'nickname': 'xx',//nickname
    'clientType': '2',//clientType
    'userid': 'xxx',//userid
}));
```

### 回放

```dart
FlutterTky.viewBack('your play back url');
```

### 回调

```dart
FlutterTky.setHandler();
```

### 更多详细信息请参阅拓课云文档

[Android](https://showdoc.talk-cloud.com/web/#/116)  
[IOS](https://showdoc.talk-cloud.com/web/#/115)