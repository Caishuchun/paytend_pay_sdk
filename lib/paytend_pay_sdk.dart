import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytend_pay_sdk/api/PayApi.dart';

import 'api/UnifiedOrderBean.dart';
import 'listener/PayListener.dart';

class PaytendPaySdk {
  static const MethodChannel _channel = const MethodChannel('paytend_pay_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void pay(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    PayApi.instance.pay(context, unifiedOrderBean, _payListener);
  }
}
