class DioConfig {
  // static const String baseURL = "https://pos.paytend.com/api";
  static const String baseURL = "http://218.97.161.247:8055/api/pay";
  static const int connectTimeOut = 10000; //毫秒
  static const int sendTimeOut = 10000; //毫秒
  static const int receiveTimeOut = 10000; //毫秒

  static const String unifiedOrder = baseURL + "/unifiedOrder.htm";
  static const String sendQpay = baseURL + "/qpay/sendQpay.htm";
  static const String queryOrder = baseURL + "/qpay/queryOrder.htm";
}
