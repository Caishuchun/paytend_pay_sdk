import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/operate/Operate.dart';

import 'bean/UnifiedOrderBean.dart';
import 'listener/PayListener.dart';

class PaytendPaySdk {
  static void pay(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    Operate.instance.pay(context, unifiedOrderBean, _payListener);
  }
}
