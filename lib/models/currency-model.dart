class CurrencyModel {
  String id;
  String symbol;
  String name;
  double? margetPrice;
  DateTime? timestamp;
  bool isFav;
  String? logo;
  bool isUp;
  double? margetPriceBath;
  double high;
  double low;
  double percentChange;
  bool isNotif;

  CurrencyModel({
    required this.id,
    required this.symbol,
    required this.name,
    this.margetPrice,
    this.margetPriceBath,
    this.timestamp,
    this.isFav = false,
    this.logo,
    required this.low,
    required this.high,
    this.isUp = false,
    this.isNotif = false,
    required this.percentChange,
  }) {
    getMargetPriceBath();
    getLogo();
  }

  bool get getNotif => isNotif;

  @override
  String toString() {
    // TODO: implement toString
    return this.toString();
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      margetPrice: json['metrics']['market_data']['price_usd'] as double,
      high: json['metrics']['market_data']['ohlcv_last_24_hour']['high'],
      low: json['metrics']['market_data']['ohlcv_last_24_hour']['low'],
      percentChange: json['metrics']['market_data']
          ['percent_change_usd_last_24_hours'],
      timestamp: json['timestamp'],
    );
  }

  void getLogo() {
    switch (symbol) {
      case 'BTC':
        logo = 'assets/images/btc.png';
        break;
      case 'ETH':
        logo = 'assets/images/eth.png';
        break;
      case 'BNB':
        logo = 'assets/images/bnb.png';
        break;
      case 'USDT':
        logo = 'assets/images/usdt.png';
        break;
      case 'SOL':
        logo = 'assets/images/sol.png';
        break;
      case 'ADA':
        logo = 'assets/images/ada.png';
        break;
      case 'USDC':
        logo = 'assets/images/usdc.png';
        break;
      case 'XRP':
        logo = 'assets/images/xrp.png';
        break;
      case 'DOT':
        logo = 'assets/images/dot.png';
        break;
      case 'LUNA':
        logo = 'assets/images/luna.png';
        break;
      case 'DOGE':
        logo = 'assets/images/doge.png';
        break;
      case 'AVAX':
        logo = 'assets/images/avax.png';
        break;
      case 'SHIB':
        logo = 'assets/images/shib.png';
        break;
      case 'MATIC':
        logo = 'assets/images/matic.png';
        break;
      case 'BUSD':
        logo = 'assets/images/busd.png';
        break;
      case 'WBTC':
        logo = 'assets/images/wbtc.png';
        break;
      case 'LTC':
        logo = 'assets/images/ltc.png';
        break;
      case 'UNI':
        logo = 'assets/images/uni.png';
        break;
      case 'ALGO':
        logo = 'assets/images/algo.png';
        break;

      default:
        logo = '';
        {}
    }
  }

  void getMargetPriceBath() {
    margetPriceBath = margetPrice! * 33.4;
  }
}
