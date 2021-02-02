class Request4SendQpay {
  String merchantId; //聚财通分配的商户号
  String sub_merchantId; //聚财通分配的子商户号
  String out_trade_no; //商户系统内部的订单号,32个字符内、可包含字母,确保在商 户系统唯一
  String currency; //币种,暂时仅支持EUR
  String total_fee; //订单金额，单位为分，只能是整数
  String card_no; //卡号
  String name; //持卡人
  String cvv; //CVV
  String expired_date; //有效期
  String mobile; //预留手机号
  String card_token; //币种,暂时仅支持EUR
  String body; //商品描述
  String sub_mch_notify_url; //接收聚财通支付成功通知
  String nonce_str;
  String sign;

  Map<String, String> toMapWithoutSign() {
    Map<String, String> map = {};
    map['merchantId'] = this.merchantId;
    map['sub_merchantId'] = this.sub_merchantId;
    map['out_trade_no'] = this.out_trade_no;
    map['currency'] = this.currency;
    map['total_fee'] = this.total_fee;
    // map['pay_type'] = this.pay_type;//不用于签名
    map['card_no'] = this.card_no;
    map['name'] = this.name;
    map['cvv'] = this.cvv;
    map['expired_date'] = this.expired_date;
    map['mobile'] = this.mobile;
    map['card_token'] = this.card_token;
    map['body'] = this.body;
    map['sub_mch_notify_url'] = this.sub_mch_notify_url;
    map['nonce_str'] = this.nonce_str;
    return map;
  }

  Map<String, String> toMap() {
    Map<String, String> map = {};
    map['merchantId'] = this.merchantId;
    map['sub_merchantId'] = this.sub_merchantId;
    map['out_trade_no'] = this.out_trade_no;
    map['currency'] = this.currency;
    map['total_fee'] = this.total_fee;
    map['card_no'] = this.card_no;
    map['name'] = this.name;
    map['cvv'] = this.cvv;
    map['expired_date'] = this.expired_date;
    map['mobile'] = this.mobile;
    map['card_token'] = this.card_token;
    map['body'] = this.body;
    map['sub_mch_notify_url'] = this.sub_mch_notify_url;
    map['nonce_str'] = this.nonce_str;
    map['sign'] = this.sign;
    return map;
  }
}
