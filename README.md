# paytend_pay_sdk

这是paytendPaySDK(Flutter版本)

## 使用方式

#### 1.  导入

    //这是必须导入的两个包
	import 'package:paytend_pay_sdk/paytend_pay_sdk.dart';
	import 'package:paytend_pay_sdk/bean/UnifiedOrderBean.dart';
	//这是可选的导包--各种工具类(其中isShow表示是否打印有日志和弹出taost,正式使用请改成false)
	import 'package:paytend_pay_sdk/utils/Utils.dart';

#### 2.  实现 UnifiedOrderBean,传入参数详情可以参考示例代码

#### 3.  调用

	PaytendPaySdk.pay(context, unifiedOrderBean, (code, value) {
	  Utils.log('code==>$code,value==>$value');
	});

#### 4.  Utils是提供了的常用以及必要的工具类,包含MD5加密,获取格式化系统时间,获取随机字符串,打印日志,弹出Toast等

#### 5.  PayListener回调返回一个map,包含"code"和"result","code":0 交易成功,-1 交易失败,2 交易取消;"result":是个dynamic类型,返回对应的描述结果

#### 6.  需要注意1: UnifiedOrderBean的pay_type参数当传1(万事达卡)的时候,直接跳转到卡信息输入界面,当不是1的时候,需要选择一次交易支付方式(当然现在仅支持MasterCard,后续会增加VISA卡,银联卡,微信,支付宝).

#### 7.  需要注意2: 由于flutter现有版本和flutter_cupertino_date_picker插件不同步,可能会报错"Error: Type 'DiagnosticableMixin' not found.",处理方式为:

	点击pay()方法,进入底层Operate.dart
	==>在导入中找到并进入MasterCardPage.dart
	==>找到并点击进入DateTimePickerTheme.dart
	==>将with的DiagnosticableMixin修改为Diagnosticable即可
