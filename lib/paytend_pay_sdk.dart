import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/api/PayApi.dart';

import 'api/UnifiedOrderBean.dart';
import 'listener/PayListener.dart';

class PaytendPaySdk {
  static void pay(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    PayApi.instance.pay(context, unifiedOrderBean, _payListener);
  }
}
