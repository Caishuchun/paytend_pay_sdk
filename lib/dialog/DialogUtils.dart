import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/listener/SelectTypeListener.dart';

import 'LoadingDialog.dart';
import 'TransTypeDialog.dart';

/// DialogUtils 工具类
class DialogUtils {
  /// showLoading 展示加载框
  static showLoading(context) {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            child: LoadingDialog(),
            onWillPop: () async => false,
          );
        });
  }

  /// showLoading 展示支付方式
  static showTransTypeDialog(context, SelectTypeListener listener) {
    showDialog(
        context: context,
        builder: (context) {
          return TransTypeDialog(selectTypeListener: listener);
        });
  }

  /// dismissDialog 取消加载框
  static dismissDialog(context) {
    Navigator.pop(context);
  }
}
