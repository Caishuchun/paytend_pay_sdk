import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/utils/Toast.dart';

import 'DateUtils.dart';
import 'MD5Utils.dart';
import 'RandomUtils.dart';

class Utils {
  /// 是否显示logger和toast
  static bool isShow = true;

  /// MD5加密
  static String generateMd5(
      Map<String, String> map, String key, bool emptyParamIsSign) {
    return MD5Utils.generateMd5(map, key, emptyParamIsSign);
  }

  ///获取系统时间,格式:YYYY-MM-DD HH:mm:ss
  static String getSystemTime() {
    return DateUtils.getSystemTime();
  }

  ///获取系统时间,格式:YYYYMMDDHHmmss
  static String getSystemFormatTime() {
    return DateUtils.getSystemFormatTime();
  }

  ///获取随机字符串,仅包含数字
  static getRandomNumStr(int len) {
    return RandomUtils.getRandomNumStr(len);
  }

  ///获取随机字符串
  static getRandomStr(int len) {
    return RandomUtils.getRandomStr(len);
  }

  ///日志打印
  static log(dynamic s) {
    if (isShow) {
      print(s);
    }
  }

  ///toast
  static toast(BuildContext context, String msg) {
    if (isShow) {
      Toast.toast(context, msg);
    }
  }
}
