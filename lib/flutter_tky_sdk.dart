import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'tky_config.dart';
import 'tky_room_obj.dart';

///无参回调
typedef SF = void Function() Function();

///int回调
typedef IntF = void Function() Function(int i);

///String回调
typedef StringF = void Function() Function(String s);

///Map回调
typedef MapF = void Function() Function(Map<String, dynamic> data);

///拓课云SDK封装
class FlutterTky {
  const FlutterTky._();

  ///通道
  static const MethodChannel _channel = MethodChannel('flutter_tky');

  ///教室内配置(仅适用于Android)
  static Future<void> setConfig(TkyConfig config) async {
    try {
      await _channel.invokeMethod<void>('setConfig',
          Platform.isAndroid ? config.toString() : config.toJson());
    } catch (e) {
      print('进入拓课云回放出错:$e');
    }
  }

  ///进教室
  static Future<void> joinRoom(TkyRoomObj obj) async {
    try {
      await _channel.invokeMethod<void>(
          'joinClassRoom', Platform.isAndroid ? obj.toString() : obj.toJson());
    } catch (e) {
      print('进入拓课云教室出错:$e');
    }
  }

  ///回放
  static Future<void> viewBack(String url) async {
    try {
      await _channel.invokeMethod<void>('tkyViewBack', url);
    } catch (e) {
      print('进入拓课云回放出错:$e');
    }
  }

  ///设置回调
  static Future<void> setHandler({
    StringF? exitRoom,
    IntF? callBack,
    MapF? onKickOut,
    IntF? onWarning,
    SF? onClassBegin,
    SF? onClassDismiss,
    MapF? onEnterRoomFailed,
    SF? joinRoomComplete,
    SF? onCameraDidOpenError,
    SF? onOpenEyeProtection,
  }) async {
    try {
      ///添加回调
      _channel.setMethodCallHandler((MethodCall call) async {
        switch (call.method) {

          ///退出教室
          case 'exitTkyRoom':
            exitRoom?.call(call.arguments.toString());
            break;
          case 'callBack':
            callBack?.call(int.tryParse(call.arguments.toString()) ?? 0);
            break;
          case 'onKickOut':
            onKickOut?.call(
                json.decode(call.arguments.toString()) as Map<String, dynamic>);
            break;
          case 'onWarning':
            onWarning?.call(int.tryParse(call.arguments.toString()) ?? 0);
            break;
          case 'onClassBegin':
            onClassBegin?.call();
            break;
          case 'onClassDismiss':
            onClassDismiss?.call();
            break;
          case 'onEnterRoomFailed':
            onEnterRoomFailed?.call(
                json.decode(call.arguments.toString()) as Map<String, dynamic>);
            break;
          case 'joinRoomComplete':
            joinRoomComplete?.call();
            break;
          case 'onCameraDidOpenError':
            onCameraDidOpenError?.call();
            break;
          case 'onOpenEyeProtection':
            onOpenEyeProtection?.call();
            break;

          default:
            break;
        }
      });
    } catch (e) {
      print('从原生回调出错:$e');
    }
  }
}
