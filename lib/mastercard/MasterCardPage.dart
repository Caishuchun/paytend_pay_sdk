import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:paytend_pay_sdk/bean/Request4QueryOrder.dart';
import 'package:paytend_pay_sdk/bean/Request4SendQpay.dart';
import 'package:paytend_pay_sdk/bean/Request4UnifiedOrder.dart';
import 'package:paytend_pay_sdk/bean/Response4UnifiedOrder.dart';
import 'package:paytend_pay_sdk/dialog/DialogUtils.dart';
import 'package:paytend_pay_sdk/http/DioConfig.dart';
import 'package:paytend_pay_sdk/http/DioUtils.dart';
import 'package:paytend_pay_sdk/listener/PayListener.dart';
import 'package:paytend_pay_sdk/res/ResColors.dart';
import 'package:paytend_pay_sdk/utils/Utils.dart';
import 'package:paytend_pay_sdk/view/EditText.dart';
import 'package:paytend_pay_sdk/view/TextWithTopBottom.dart';

class MasterCardPage extends StatelessWidget {
  final Request4UnifiedOrder request4unifiedOrder;
  final Response4UnifiedOrder response4unifiedOrder;
  final PayListener _payListener;

  MasterCardPage(this.request4unifiedOrder, this.response4unifiedOrder,
      this._payListener);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("银行卡支付"),
            centerTitle: true,
          ),
          body: Home(request4unifiedOrder, response4unifiedOrder, _payListener),
        ),
        onWillPop: () async {
          Navigator.pop(context, {"code": 2, "result": "Cancel"});
          return true;
        });
  }
}

class Home extends StatefulWidget {
  final Request4UnifiedOrder request4unifiedOrder;
  final Response4UnifiedOrder response4unifiedOrder;
  final PayListener _payListener;

  Home(this.request4unifiedOrder, this.response4unifiedOrder,
      this._payListener);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _holder;
  String _cardNo;
  String _cvv;
  String _valid;
  String _valid_date;
  String _holderSave;
  String _cardNoSave;
  String _cvvSave;

  bool _isShowHolderError = false;
  bool _isShowCardNoError = false;
  bool _isShowCVVError = false;
  bool _isShowValidError = false;

  FocusNode _focusNode_holder;
  FocusNode _focusNode_cardNo;
  FocusNode _focusNode_cvv;

  @override
  void initState() {
    super.initState();
    _focusNode_holder = FocusNode();
    _focusNode_cardNo = FocusNode();
    _focusNode_cvv = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    String amount = widget.response4unifiedOrder.total_fee;
    String currency = widget.response4unifiedOrder.currency;
    if (currency == "EUR") {
      currency = "€";
    }
    amount = _formatAmount(amount);
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$currency$amount',
                style: TextStyle(
                    color: ResColors.BLACK_333333,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "付款金额",
                style: TextStyle(
                  color: ResColors.BLACK_333333,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        EditText(
          minLen: 1,
          maxLen: 20,
          inputType: InputType.OTHER,
          hintText: "持卡人",
          isShowError: _isShowHolderError,
          focusNode: _focusNode_holder,
          callback: (value) {
            if (_holderSave != value) {
              setState(() {
                _isShowHolderError = false;
              });
            }
            setState(() {
              _holder = value;
            });
          },
        ),
        EditText(
          minLen: 7,
          maxLen: 20,
          inputType: InputType.NUMBER,
          hintText: "卡号",
          isShowError: _isShowCardNoError,
          focusNode: _focusNode_cardNo,
          callback: (value) {
            if (_cardNoSave != value) {
              setState(() {
                _isShowCardNoError = false;
              });
            }
            setState(() {
              _cardNo = value;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: EditText(
                minLen: 3,
                maxLen: 3,
                inputType: InputType.NEED_HIDE,
                hintText: 'CVV',
                isShowError: _isShowCVVError,
                focusNode: _focusNode_cvv,
                callback: (value) {
                  if (_cvvSave != value) {
                    setState(() {
                      _isShowCVVError = false;
                    });
                  }
                  setState(() {
                    _cvv = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: GestureDetector(
                  child: TextWithTopBottom(
                    hintText: "有效期",
                    valueText: _valid == null ? "有效期" : _valid,
                    isShowError: _isShowValidError,
                  ),
                  onTap: _toShowDateDialog,
                )),
          ],
        ),
        SizedBox(
          height: 90,
        ),
        InkWell(
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 345,
            decoration: BoxDecoration(
                color: ResColors.GREEN_85C14F,
                borderRadius: BorderRadius.circular(25)),
            child: Text(
              "确认支付",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onTap: () {
            _focusNode_holder.unfocus();
            _focusNode_cardNo.unfocus();
            _focusNode_cvv.unfocus();
            _onNext(widget.request4unifiedOrder, widget.response4unifiedOrder);
          },
        )
      ],
    );
  }

  _formatAmount(String amount) {
    String result;
    if (amount.length == 1) {
      result = "0.0$amount";
    } else if (amount.length == 2) {
      result = "0.$amount";
    } else {
      result =
      "${amount.substring(0, amount.length - 2)}.${amount.substring(
          amount.length - 2, amount.length)}";
    }
    String num = result.split(".")[0];
    num = _formatAmount2(num);
    result = "$num.${result.split('.')[1]}";
    return result;
  }

  _formatAmount2(String num) {
    if (num.length < 3) {
      return num;
    } else if (num.length < 6) {
      return "${num.substring(0, num.length - 3)},${num.substring(
          num.length - 3, num.length)}";
    } else if (num.length < 9) {
      return "${num.substring(0, num.length - 6)},${num.substring(
          num.length - 6, num.length - 3)},${num.substring(
          num.length - 3, num.length)}";
    }
  }

  _toShowDateDialog() async {
    _focusNode_holder.unfocus();
    _focusNode_cardNo.unfocus();
    _focusNode_cvv.unfocus();
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      // 如果报错提到 DateTimePickerTheme 有问题，点开这个类的原文件作如下修改。
      // 移除'with DiagnosticableMixin'或者将'DiagnosticableMixin'改成'Diagnosticable'.
      pickerTheme: DateTimePickerTheme.Default,
      //   (
      //     showTitle: true,
      //     confirm: Text('确认', style: TextStyle(color: Colors.red)),
      //     cancel: Text('取消',style:TextStyle(color:Colors.cyan))
      // ),
      minDateTime: DateTime.parse("1970-01-01"),
      maxDateTime: DateTime.parse("2100-01-01"),
      initialDateTime: DateTime.now(),
      // 显示日期
      // dateFormat: "yyyy-MMMM-dd",
      // 显示日期与时间
      dateFormat: 'yyyy MM',
      // show TimePicker
      pickerMode: DateTimePickerMode.date,
      onConfirm: (dateTime, List<int> index) {
        Utils.log('$dateTime');
        var year =
            dateTime.toString().split(' ')[0].split('-')[0].substring(2, 4);
        var month = dateTime.toString().split(' ')[0].split('-')[1];
        setState(() {
          _isShowValidError = false;
          _valid = '$month-$year';
          _valid_date = dateTime.toString().split(' ')[0].substring(0,7);
          _valid_date="${_valid_date.split("-")[1]}-${_valid_date.split("-")[0]}";
        });
      },
    );
  }

  _onNext(Request4UnifiedOrder request, Response4UnifiedOrder response) {
    _holderSave = _holder;
    _cardNoSave = _cardNo;
    _cvvSave = _cvv;
    bool isSure = true;
    if (_holder == null || _holder.length < 1) {
      isSure = false;
      setState(() {
        _isShowHolderError = true;
      });
    }
    if (_cardNo == null || _cardNo.length < 7) {
      isSure = false;
      setState(() {
        _isShowCardNoError = true;
      });
    }
    if (_cvv == null || _cvv.length != 3) {
      isSure = false;
      setState(() {
        _isShowCVVError = true;
      });
    }
    if (_valid == null || _valid.length != 5) {
      isSure = false;
      setState(() {
        _isShowValidError = true;
      });
    }
    if (isSure) {
      _toPay(request, response, _holder, _cardNo, _cvv, _valid_date);
    }
  }

  _toPay(Request4UnifiedOrder request, Response4UnifiedOrder response,
      String holder, String cardNo, String cvv, String validDate) {
    DialogUtils.showLoading(context);
    var sendQpay = Request4SendQpay();
    sendQpay.merchantId = response.merchantId;
    sendQpay.sub_merchantId = response.sub_merchantId;
    sendQpay.out_trade_no = response.out_trade_no;
    sendQpay.currency = response.currency;
    sendQpay.total_fee = response.total_fee;
    sendQpay.card_no = cardNo;
    sendQpay.name = holder;
    sendQpay.cvv = cvv;
    sendQpay.expired_date = validDate;
    sendQpay.mobile = "";
    sendQpay.card_token = "";
    sendQpay.body = request.body;
    sendQpay.sub_mch_notify_url = request.sub_mch_notify_url;
    sendQpay.nonce_str = Utils.getRandomNumStr(32);

    sendQpay.sign = Utils.generateMd5(
        sendQpay.toMapWithoutSign(), response.sign_key, false);
    Utils.log('${sendQpay.toMap()}');

    DioUtils.request(DioConfig.sendQpay, params: sendQpay.toMap())
        .then((value) {
      if (value == null) {
        DialogUtils.dismissDialog(context);
        widget._payListener(-1, "网络异常,请检查网络");
      } else {
        Utils.log("value==>$value");
        Map result = json.decode(value);
        Utils.log("result==>$result");
        if (result['return_code'] != null &&
            result['return_code'] == 'SUCCESS') {
          DialogUtils.dismissDialog(context);
          widget._payListener(0, result['return_code']);
        } else if (result['return_code'] != null &&
            result['return_code'] != 'SUCCESS') {
          DialogUtils.dismissDialog(context);
          widget._payListener(-1, result);
        } else {
          DialogUtils.dismissDialog(context);
          widget._payListener(-1, "网络异常,请检查网络");
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
        widget._payListener(-1, "连接异常");
      } else if (error != null &&
          error.message != null &&
          (error.message.contains("time out") ||
              error.message.contains("timed out") ||
              error.message.contains("timedout") ||
              error.message.contains("timeout"))) {
        _toQuery(response);
      } else {
        widget._payListener(-1, "${error?.message}");
      }
    });
  }

  _toQuery(Response4UnifiedOrder response) {
    var queryOrder = Request4QueryOrder();
    queryOrder.merchantId = response.merchantId;
    queryOrder.sub_merchantId = response.sub_merchantId;
    queryOrder.out_trade_no = response.out_trade_no;
    queryOrder.nonce_str = Utils.getRandomStr(32);

    queryOrder.sign = Utils.generateMd5(
        queryOrder.toMapWithoutSign(), response.sign_key, false);
    // Utils.log('${queryOrder.toMap()}');
    DioUtils.request(DioConfig.queryOrder, params: queryOrder.toMap())
        .then((value) {
      DialogUtils.dismissDialog(context);
      if (value == null) {
        widget._payListener(-1, "网络异常,请检查网络");
      } else {
        Utils.log("value==>$value");
        Map result = json.decode(value);
        Utils.log("result==>$result");
        if (result['return_code'] != null &&
            result['return_code'] == 'SUCCESS') {
          if (result['trade_state'] != null && result['trade_state'] == 1) {
            widget._payListener(0, result['return_code']);
            Navigator.pop(context);
          } else if (result['trade_state'] != null &&
              result['trade_state'] != 1) {
            widget._payListener(
                -1, 'FAIL:${_toGetTradeStateMsg(result['trade_state'])}');
          } else {
            widget._payListener(-1, 'FAIL');
          }
        } else if (result['return_code'] != null &&
            result['return_code'] != 'SUCCESS') {
          widget._payListener(-1, result['return_code']);
        } else {
          widget._payListener(-1, "网络异常,请检查网络");
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
        widget._payListener(-1, "连接异常");
      } else if (error != null &&
          error.message != null &&
          (error.message.contains("time out") ||
              error.message.contains("timed out") ||
              error.message.contains("timedout") ||
              error.message.contains("timeout"))) {
        widget._payListener(-1, "超时");
      } else {
        widget._payListener(-1, "${error?.message}");
      }
    });
  }

  _toGetTradeStateMsg(int tradeState) {
    String msg;
    switch (tradeState) {
      case 1:
        msg = "支付成功";
        break;
      case 2:
        msg = "转入退款";
        break;
      case 3:
        msg = "未支付";
        break;
      case 4:
        msg = "已关闭";
        break;
      case 5:
        msg = "已撤销";
        break;
      case 6:
        msg = "用户支付中";
        break;
      case 7:
        msg = "未支付(输入密码或确认支付超时)";
        break;
      case 8:
        msg = "支付失败(其他原因，如银行返回失败)";
        break;
    }
    return msg;
  }
}
