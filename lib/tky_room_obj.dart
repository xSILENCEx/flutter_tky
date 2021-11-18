import 'dart:convert';

///拓课云进入教室需要的对象
class TkyRoomObj {
  TkyRoomObj({
    this.host = '/global.talk-cloud.net',
    this.server = 'global',
    this.port = '443',
    this.password,
    required this.serial,
    required this.userrole,
    required this.nickname,
    required this.clientType,
    required this.userid,
  });

  TkyRoomObj.fromJson(Map<String, dynamic> d) {
    host = d['host'] as String? ?? '';
    server = d['server'] as String? ?? '';
    port = d['port'] as String? ?? '';
    clientType = d['clientType'] as String? ?? '';
    nickname = d['nickname'] as String? ?? '';
    userid = d['userid'] as String? ?? '';
    serial = d['serial'] as String? ?? '';
    userrole = d['userrole'] as String? ?? '';
    password = d['password'] as String? ?? '';
  }

  ///地址
  late String host;

  ///主机
  late String server;

  ///端口号
  late String port;

  ///客户端类型
  /// * `3`:ios
  /// * `2`:android
  late String clientType;

  ///用户昵称
  late String nickname;

  ///进入教室的学生id
  late String userid;

  ///房间号
  late String serial;

  ///进入教室用户的身份
  /// * `0`老师
  /// * `1`助教
  /// * `2`学生
  /// * `4`巡课
  late String userrole;

  ///巡课身份密码
  late String? password;

  ///转为json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serial'] = serial;
    data['userrole'] = userrole;
    data['host'] = host;
    data['server'] = server;
    data['port'] = port;
    data['nickname'] = nickname;
    data['clientType'] = clientType;
    data['userid'] = userid;
    if (password != null) data['password'] = password;

    return data;
  }

  ///转为String
  @override
  String toString() => json.encode(toJson());
}
