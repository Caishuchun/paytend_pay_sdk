import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/bean/Request4UnifiedOrder.dart';
import 'package:paytend_pay_sdk/bean/Response4UnifiedOrder.dart';
import 'package:paytend_pay_sdk/bean/UnifiedOrderBean.dart';
import 'package:paytend_pay_sdk/dialog/DialogUtils.dart';
import 'package:paytend_pay_sdk/http/DioConfig.dart';
import 'package:paytend_pay_sdk/http/DioUtils.dart';
import 'package:paytend_pay_sdk/listener/PayListener.dart';
import 'package:paytend_pay_sdk/mastercard/MasterCardPage.dart';
import 'package:paytend_pay_sdk/utils/Utils.dart';

class Operate {
  factory Operate() => _getInstance();

  static Operate get instance => _getInstance();
  static Operate _instance;

  Operate._internal();

  static Operate _getInstance() {
    if (_instance == null) {
      _instance = Operate._internal();
    }
    return _instance;
  }

  void pay(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    var toCheck = _toCheck(unifiedOrderBean);
    if (toCheck["code"] == 0) {
      if (unifiedOrderBean != null && unifiedOrderBean.pay_type == "1") {
        _toUnifiedOrder(context, unifiedOrderBean, _payListener);
      } else if (unifiedOrderBean != null && unifiedOrderBean.pay_type != "1") {
        _toSelectType(context, unifiedOrderBean, _payListener);
      }
    } else {
      _payListener(-1, toCheck["result"]);
    }
  }

  _toCheck(UnifiedOrderBean unifiedOrderBean) {
    if (unifiedOrderBean == null) {
      return {"code": -1, "result": "unifiedOrderBean is null"};
    } else {
      if (unifiedOrderBean.merchantId == null ||
          unifiedOrderBean.merchantId == "") {
        return {"code": -1, "result": "invalid merchantId"};
      }
      if (unifiedOrderBean.sub_merchantId == null ||
          unifiedOrderBean.sub_merchantId == "") {
        return {"code": -1, "result": "invalid sub_merchantId"};
      }
      if (unifiedOrderBean.out_trade_no == null ||
          unifiedOrderBean.out_trade_no == "") {
        return {"code": -1, "result": "invalid out_trade_no"};
      }
      if (unifiedOrderBean.currency == null ||
          unifiedOrderBean.currency == "") {
        return {"code": -1, "result": "invalid currency"};
      }
      if (unifiedOrderBean.total_fee == null ||
          unifiedOrderBean.total_fee == "") {
        return {"code": -1, "result": "invalid total_fee"};
      }
      // if(unifiedOrderBean.pay_type==null || unifiedOrderBean.pay_type ==""){
      //   return {"code":-1,"result":"invalid pay_type"};
      // }
      if (unifiedOrderBean.client_date == null ||
          unifiedOrderBean.client_date == "") {
        return {"code": -1, "result": "invalid client_date"};
      }
      if (unifiedOrderBean.sub_mch_notify_url == null ||
          unifiedOrderBean.sub_mch_notify_url == "") {
        return {"code": -1, "result": "invalid sub_mch_notify_url"};
      }
      if (unifiedOrderBean.body == null || unifiedOrderBean.body == "") {
        return {"code": -1, "result": "invalid body"};
      }
    }
    return {"code": 0, "result": "values is sure"};
  }

  _toSelectType(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    DialogUtils.showTransTypeDialog(context, (type) {
      unifiedOrderBean.pay_type = type;
      _toUnifiedOrder(context, unifiedOrderBean, _payListener);
    });
  }

  _toUnifiedOrder(BuildContext context, UnifiedOrderBean unifiedOrderBean,
      PayListener _payListener) {
    DialogUtils.showLoading(context);
    var order = Request4UnifiedOrder();
    order.merchantId = unifiedOrderBean.merchantId;
    order.client_date = unifiedOrderBean.client_date;
    order.sub_merchantId = unifiedOrderBean.sub_merchantId;
    order.out_trade_no = unifiedOrderBean.out_trade_no;
    order.body = unifiedOrderBean.body;
    order.sub_mch_notify_url = unifiedOrderBean.sub_mch_notify_url;
    order.total_fee = unifiedOrderBean.total_fee;
    order.currency = unifiedOrderBean.currency;
    order.pay_type = unifiedOrderBean.pay_type;
    order.nonce_str = unifiedOrderBean.nonce_str;
    order.card_token = unifiedOrderBean.card_token; //card_token,如果有会查询卡信息

    order.sign =
        Utils.generateMd5(order.toMapWithoutSign(), "flzs77MFfUg0I63H", false);
    Utils.log('${order.toMap()}');

    DioUtils.request(DioConfig.unifiedOrder, params: order.toMap())
        .then((value) {
      DialogUtils.dismissDialog(context);
      if (value == null) {
        _payListener(-1, "网络异常,请检查网络");
      } else {
        Utils.log("value==>$value");
        Map result = json.decode(value);
        Utils.log("result==>$result");
        if (result['return_code'] != null &&
            result['return_code'] == 'SUCCESS') {
          _toNext(context, order, result, _payListener);
        } else if (result['return_code'] != null &&
            result['return_code'] != 'SUCCESS') {
          _payListener(-1, result);
        } else {
          _payListener(-1, "网络异常,请检查网络");
        }
      }
    }).catchError((error) {
      DialogUtils.dismissDialog(context);
      if (error != null &&
          error.message != null &&
          (error.message.contains("No address associated with hostname") ||
              error.message.contains("Software caused connection abort") ||
              error.message.contains("failed to connect") ||
              error.message.contains("reset") ||
              error.message.contains("404"))) {
        _payListener(-1, "连接异常");
      } else if (error != null &&
          error.message != null &&
          (error.message.contains("time out") ||
              error.message.contains("timed out") ||
              error.message.contains("timedout") ||
              error.message.contains("timeout"))) {
        _payListener(-1, "超时");
      } else {
        _payListener(-1, "${error?.message}");
      }
    });
  }

  _toNext(context, order, info, _payListener) async {
    var response = Response4UnifiedOrder(
        info['merchantId'],
        info['sub_merchantId'],
        info['total_fee'],
        info['currency'],
        info['out_trade_no'],
        info['sign_key']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MasterCardPage(order, response, _payListener)));
  }
}
