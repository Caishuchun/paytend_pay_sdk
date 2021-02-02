class Request4UnifiedOrder {
  String merchantId; //聚财通分配的商户号
  String sub_merchantId; //聚财通分配的子商户号
  String out_trade_no; //商户系统内部的订单号,32个字符内、可包含字母,确保在商 户系统唯一
  String currency; //币种,暂时仅支持EUR
  String total_fee; //订单金额，单位为分，只能是整数
  String pay_type; //支付方式，1：万事达卡快捷
  String card_token; //币种,暂时仅支持EUR
  String client_date; //YYYY-MM-DD HH:mm:ss
  String sub_mch_notify_url; //接收聚财通支付成功通知
  String body; //商品描述
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
    map['card_token'] = this.card_token;
    map['client_date'] = this.client_date;
    map['sub_mch_notify_url'] = this.sub_mch_notify_url;
    map['body'] = this.body;
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
    map['pay_type'] = this.pay_type;
    map['card_token'] = this.card_token;
    map['client_date'] = this.client_date;
    map['sub_mch_notify_url'] = this.sub_mch_notify_url;
    map['body'] = this.body;
    map['nonce_str'] = this.nonce_str;
    map['sign'] = this.sign;
    return map;
  }
}
