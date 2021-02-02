class Response4UnifiedOrder {
  String merchantId;
  String sub_merchantId;
  String total_fee;
  String currency;
  String out_trade_no;
  String sign_key;

  Response4UnifiedOrder(
    this.merchantId,
    this.sub_merchantId,
    this.total_fee,
    this.currency,
    this.out_trade_no,
    this.sign_key,
  );
}
