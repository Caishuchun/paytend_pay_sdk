class Request4QueryOrder {
  String merchantId; //聚财通分配的商户号
  String sub_merchantId; //聚财通分配的子商户号
  String out_trade_no; //商户系统内部的订单号,32个字符内、可包含字母,确保在商 户系统唯一
  String nonce_str;
  String sign;

  Map<String, String> toMapWithoutSign() {
    Map<String, String> map = {};
    map['merchantId'] = this.merchantId;
    map['sub_merchantId'] = this.sub_merchantId;
    map['out_trade_no'] = this.out_trade_no;
    map['nonce_str'] = this.nonce_str;
    return map;
  }

  Map<String, String> toMap() {
    Map<String, String> map = {};
    map['merchantId'] = this.merchantId;
    map['sub_merchantId'] = this.sub_merchantId;
    map['out_trade_no'] = this.out_trade_no;
    map['nonce_str'] = this.nonce_str;
    map['sign'] = this.sign;
    return map;
  }
}
