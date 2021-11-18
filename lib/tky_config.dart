import 'dart:convert';

///拓课云教室配置
///教室内配置
class TkyConfig {
  TkyConfig(this.appName, this.logo, this.crashTag);

  ///应用名id值
  final int appName;

  ///应用logo id值
  final int logo;

  ///日志标识
  final String crashTag;

  ///转为json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appName'] = appName;
    data['logo'] = logo;
    data['crashTag'] = crashTag;
    return data;
  }

  ///转为String
  @override
  String toString() => json.encode(toJson());
}
