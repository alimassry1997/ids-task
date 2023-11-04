class Stock {
  String? symbolEn;
  double? last;
  double? open;
  double? volume;
  double? amount;
  double? low;
  double? high;
  double? closingPrice;
  double? changePercent;
  dynamic tradeDate;

  Stock(
      {this.symbolEn,
      this.last,
      this.open,
      this.volume,
      this.amount,
      this.low,
      this.high,
      this.closingPrice,
      this.changePercent,
      this.tradeDate});

  Stock.fromJson(Map<String, dynamic> json) {
    symbolEn = json["symbolEn"];
    last = (json["last"] as num).toDouble();
    open = (json["open"] as num).toDouble();
    volume = (json["volume"] as num).toDouble();
    amount = (json["amount"] as num).toDouble();
    low = (json["low"] as num).toDouble();
    high = (json["high"] as num).toDouble();
    closingPrice = (json["closingPrice"] as num).toDouble();
    changePercent = (json["changePercent"] as num).toDouble();
    tradeDate = json["tradeDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["symbolEn"] = symbolEn;
    data["last"] = last;
    data["open"] = open;
    data["volume"] = volume;
    data["amount"] = amount;
    data["low"] = low;
    data["high"] = high;
    data["closingPrice"] = closingPrice;
    data["changePercent"] = changePercent;
    data["tradeDate"] = tradeDate;
    return data;
  }
}
