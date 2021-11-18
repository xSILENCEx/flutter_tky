import 'package:flutter/material.dart';
import 'package:flutter_tky/flutter_tky.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  FlutterTky.joinRoom(TkyRoomObj.fromJson(<String, dynamic>{
                    'serial': 'xxxxx',
                    'userrole': 'x',
                    'host': 'xxxxx',
                    'server': 'xxx',
                    'port': 'xx',
                    'nickname': 'xx',
                    'clientType': 'x',
                    'userid': 'xxx',
                  }));
                },
                child: const Text('Enter Class Room'),
              ),
              TextButton(
                onPressed: () {
                  FlutterTky.viewBack('play back url');
                },
                child: const Text('View Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
