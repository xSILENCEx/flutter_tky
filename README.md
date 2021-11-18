# flutter_tky

A Flutter plugin of talk_cloud sdk.

### 添加依赖

```dart
flutter_tky:
    git:
        url: https://github.com/xSILENCEx/flutter_tky
        ref: master
```

### 进入教室

```dart
FlutterTky.joinRoom(TkyRoomObj.fromJson(<String, dynamic>{
    'serial': 'xxxxx',//serial
    'userrole': 'x',//userrole
    'host': 'xxx',//host
    'server': 'xxx',//server
    'port': 'xxx',//port
    'nickname': 'xx',//nickname
    'clientType': 'xx',//clientType
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

### 接入所需参数请联系拓课云