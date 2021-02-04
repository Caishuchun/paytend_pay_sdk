class UnifiedOrderBean {
  String merchantId; //聚财通分配的商户号
  String sub_merchantId; //聚财通分配的子商户号
  String out_trade_no; //商户系统内部的订单号,32个字符内、可包含字母,确保在商 户系统唯一
  String currency; //币种,暂时仅支持EUR
  String total_fee; //订单金额，单位为分，只能是整数
  String pay_type; //支付方式，1：万事达卡快捷
  String card_token; //pay_type=1时生效，pay_type=1时生效，卡Token
  String client_date; //YYYY-MM-DD HH:mm:ss
  String sub_mch_notify_url; //接收聚财通支付成功通知
  String body; //商品描述
  String nonce_str; //32位的随机字符串
  String key;

  UnifiedOrderBean(
      this.merchantId,
      this.sub_merchantId,
      this.out_trade_no,
      this.currency,
      this.total_fee,
      this.pay_type,
      this.card_token,
      this.client_date,
      this.sub_mch_notify_url,
      this.body,
      this.nonce_str,
      this.key);
}
