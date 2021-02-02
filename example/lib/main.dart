import 'package:flutter/material.dart';
import 'package:paytend_pay_sdk/api/PayApi.dart';
import 'package:paytend_pay_sdk/api/UnifiedOrderBean.dart';
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
                      //merchantId
                        "000000000000003",
                        //sub_merchantId
                        "188001000000086",
                        //out_trade_no
                        Utils.getSystemFormatTime() + Utils.getRandomNumStr(4),
                        //currency
                        'EUR',
                        //total_fee
                        "100000",
                        //pay_type
                        '2',
                        //card_token
                        "",
                        //client_date
                        Utils.getSystemTime(),
                        //sub_mch_notify_url
                        "http://www.paytend.com",
                        //body
                        "12102132151515",
                        //nonce_str
                        Utils.getRandomStr(32));
                    PayApi.instance.pay(context, unifiedOrderBean, (code, value) {
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
