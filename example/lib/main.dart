import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/paytend_pay_sdk.dart';
import 'package:paytend_pay_sdk/bean/UnifiedOrderBean.dart';
import 'package:paytend_pay_sdk/utils/Utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            RaisedButton(
              child: Text('Pay'),
              onPressed: () {
                var unifiedOrderBean = UnifiedOrderBean(
                    //merchantId 商户号
                    "000000000000003",
                    //sub_merchantId 子商户号
                    "188001000000086",
                    //out_trade_no 商户系统内部的订单号,32个字符内、可包含字母,确保在商 户系统唯一
                    'abcdefghojklmnopqrstuvwsyz',
                    //currency 币种,暂时仅支持EUR
                    'EUR',
                    //total_fee 订单金额，单位为分，只能是整数
                    "100000",
                    //pay_type 支付方式，1：万事达卡快捷
                    //TODO: 如果先行传值过来pay_type=1,直接跳转到输入卡信息界面;如果不是1,则需要在支付方式界面再进行一次选择,
                    '2',
                    //card_token pay_type=1时生效，卡Token
                    "",
                    //client_date YYYY-MM-DD HH:mm:ss
                    Utils.getSystemTime(),
                    //sub_mch_notify_url 接收聚财通支付成功通知
                    "http://www.paytend.com",
                    //body 商品描述
                    "12102132151515",
                    //nonce_str 32位的随机字符串
                    Utils.getRandomStr(32));
                PaytendPaySdk.pay(context, unifiedOrderBean, (code, value) {
                  Utils.log('code==>$code,value==>$value');
                });
              },
            ),
          ],
        )),
      ),
    );
  }
}
