import 'package:intl/intl.dart';

class TransactionModel {
  String? _dealType;
  double? _amount;
  String? _tokenName;
  DateTime? _time;
  String? _address;

  TransactionModel(Map transact) {
    _parseTransaction(transact);
  }

  String get dealType => _dealType ?? 'sent';
  double get amount => _amount ?? 0;
  String get tokenName => _tokenName ?? 'unknown';
  String get address => _address ?? 'unknown address';
  String get shortAddress => _getShortString() ?? 'unknown address';
  DateTime get dateTime => _time ?? DateTime.now();
  String get timeString => _getFormatTimeString() ?? 'unknown time';

  String? _getShortString() {
    if (_address == null || _address!.length < 30) {
      return null;
    }
    return _address!.substring(0, 8) +
        "..." +
        _address!.substring(_address!.length - 6);
  }

  String? _getFormatTimeString() {
    if (_time == null) {
      return null;
    }
    int timestampPre = _time!.millisecondsSinceEpoch;
    int timestampNow = DateTime.now().millisecondsSinceEpoch;
    if ((timestampNow - timestampPre).abs() < 60000) { // < 1 minute
      return "刚刚";
    }
    if ((timestampNow - timestampPre).abs() < 3600000) { // < 1 hour
      double seconds = (timestampNow - timestampPre).abs() / 1000;
      int minutes = (seconds / 60).floor();
      return "$minutes分钟前";
    }
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(_time!);
  }

  void _parseTransaction(Map transact) {
    dynamic dType = transact['type'];
    _dealType = dType == 0 ? 'sent' : 'received';
    _amount = (transact['amount'] as num).toDouble();
    _tokenName = transact['token'];
    var timestamp = transact['time'];
    _time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    _address = transact['address'];
  }
}