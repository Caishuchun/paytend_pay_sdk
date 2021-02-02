import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/listener/PayListener.dart';
import 'package:paytend_pay_sdk/operate/Operate.dart';

import 'UnifiedOrderBean.dart';

class PayApi {
  factory PayApi() => _getInstance();

  static PayApi get instance => _getInstance();
  static PayApi _instance;

  PayApi._internal();

  static PayApi _getInstance() {
    if (_instance == null) {
      _instance = PayApi._internal();
    }
    return _instance;
  }

  void pay(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    Operate.instance.pay(context, unifiedOrderBean, _payListener);
  }
}
