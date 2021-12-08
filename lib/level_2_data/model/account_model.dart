
class AccountModel {

  String? _name;
  String? _address;

  AccountModel._internal();
  static late final AccountModel _instance = AccountModel._internal();
  factory AccountModel() => _instance;

  String? name() => _name;
  String? address() => _address;

  void update({
    String? name = "anonymous",
    String? address = "eth_lasfjoweilgdfsnxmncvjladofwoiurowrouweonlsfalksdnfnx",
  }) {
    _name = name;
    _address = address;
  }
}