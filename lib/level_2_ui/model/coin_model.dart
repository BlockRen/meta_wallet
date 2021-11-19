import 'package:meta_wallet/level_1_core/util/magic_value.dart';

class CoinModel {
  String? _name;
  String? _icon;
  String? _price;
  String? _dayChange;
  String? _dayVolume;
  String? _hourVolume;

  CoinModel(Map coinInfo) {
    _parseCoinInfo(coinInfo);
  }

  String get name => _name ?? "unknown";
  String get icon => _icon ?? "unknown";
  String get price => _price ?? "unknown";
  String get dayChange => _dayChange ?? "unknown";
  String get dayVolume => _dayVolume ?? "unknown";
  String get hourVolume => _hourVolume ?? "unknown";

  void _parseCoinInfo(Map coinInfo) {
    _name = coinInfo['CoinInfo']['Name'];
    _icon = MagicValue.marketIconPrefixUrl + coinInfo['CoinInfo']['ImageUrl'];
    _price = coinInfo['DISPLAY']['USD']['PRICE'];
    _dayChange = coinInfo['DISPLAY']['USD']['CHANGEDAY'];
    _dayVolume = coinInfo['DISPLAY']['USD']['VOLUMEDAYTO'];
    _hourVolume = coinInfo['DISPLAY']['USD']['VOLUMEHOURTO'];
  }
}