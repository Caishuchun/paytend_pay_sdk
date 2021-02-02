import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/bean/PayType.dart';
import 'package:paytend_pay_sdk/listener/SelectTypeListener.dart';
import 'package:paytend_pay_sdk/res/ResColors.dart';

class TransTypeDialog extends StatefulWidget {
  final SelectTypeListener selectTypeListener;

  TransTypeDialog({this.selectTypeListener});

  @override
  _TransTypeDialogState createState() => _TransTypeDialogState();
}

class _TransTypeDialogState extends State<TransTypeDialog> {
  List<Map> _transTypes = [
    {
      'icon': 'images/master.png',
      'text': PayType.MASTERCARD,
      'isChecked': false
    },
    {'icon': 'images/visa.png', 'text': PayType.VISA, 'isChecked': false},
    {
      'icon': 'images/unionpay.png',
      'text': PayType.UnionPay,
      'isChecked': false
    },
    {
      'icon': 'images/wechat.png',
      'text': PayType.WechatPay,
      'isChecked': false
    },
    {'icon': 'images/alipay.png', 'text': PayType.AliPay, 'isChecked': false},
  ];

  Widget _getItem(info) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 57,
      child: InkWell(
        child: Column(
          children: [
            Divider(
              height: 1,
              color: ResColors.GREY_C8C7CC,
            ),
            ListTile(
              leading: Image.asset(
                info['icon'],
                package: 'paytend_pay_sdk',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              title: Text(
                _getTrans(info['text']),
                style: TextStyle(color: ResColors.BLACK_333333, fontSize: 16),
              ),
              trailing: info['isChecked']
                  ? Image.asset(
                      'images/selected.png',
                      package: 'paytend_pay_sdk',
                      width: 22,
                      height: 22,
                    )
                  : Image.asset(
                      'images/unselect.png',
                      package: 'paytend_pay_sdk',
                      width: 22,
                      height: 22,
                    ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _transTypes.forEach((element) {
              element == info
                  ? element['isChecked'] = true
                  : element['isChecked'] = false;
            });
          });
          if (PayType.MASTERCARD == info['text']) {
            Navigator.pop(context);
            widget.selectTypeListener('1');
            //跳转
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MasterCardPage()));
          }
        },
      ),
    );
  }

  String _getTrans(PayType payType) {
    String _trans;
    switch (payType) {
      case PayType.MASTERCARD:
        _trans = "万事达卡支付";
        break;
      case PayType.VISA:
        _trans = "VISA卡支付";
        break;
      case PayType.UnionPay:
        _trans = "银联卡支付";
        break;
      case PayType.WechatPay:
        _trans = "微信支付";
        break;
      case PayType.AliPay:
        _trans = "支付宝支付";
        break;
    }
    return _trans;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 353,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "选择支付方式",
                        style: TextStyle(
                          fontSize: 17,
                          color: ResColors.BLACK_333333,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children:
                          _transTypes.map((info) => _getItem(info)).toList(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
