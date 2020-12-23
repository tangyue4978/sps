
import 'dart:async';

import 'package:flutter/services.dart';

class Sps {
  static const MethodChannel _channel =
      const MethodChannel('sps');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /*
  * 处理返回的信息
  * */
  Future<TuYaResult> handleResult(info) async {
    print ("信息结果 。。。。。。 ${info["code"]}");
    print (info["msg"]);
    final TuYaResult result = new TuYaResult();
    result.setRest(int.parse(info["code"]), info["msg"], info["data"]);

    return result;
  }

  // 配网
  Future<TuYaResult> setECNet(String homeId, String ssid, String password) async {
    var info = await _channel.invokeMethod("set_ec_net", {
      'homeId': homeId,
      'ssid': ssid,
      'password': password,
    });

    return this.handleResult(info);
  }
}

/// 返回结果
class TuYaResult {
  /// 返回码:
  ///  (0 成功 -1 失败 其他为错误码)
  int code;

  /// 错误原因
  String msg;

  /// 可能存在的信息
  String data;

  void setRest(int code, String msg, String data) {
    this.code = code;
    this.msg = msg;
    this.data = data;
  }

  @override
  String toString() {
    String result = '{retCode:$code,retMsg:$msg,data:$data}';
    return result;
  }
}