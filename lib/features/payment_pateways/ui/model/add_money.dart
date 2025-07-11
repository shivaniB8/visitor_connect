import 'package:flutter/widgets.dart';

class AddMoney extends ChangeNotifier {

  /// --------------------------------- amount
  String _amount = '';

  String get amount => _amount;

  set amount(String amount) {
    _amount = amount;
    notifyListeners();
  }

  /// --------------------------------- reason
  String _reason = '';

  String get reason => _reason;

  set reason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  /// --------------------------------- payment mode
  int _paymentMode = 0;

  int get paymentMode => _paymentMode;

  set paymentMode(int paymentMode) {
    _paymentMode = paymentMode;
    notifyListeners();
  }

  /// --------------------------------- host id
  int _hostId = 0;

  int get hostId => _hostId;

  set setHostId(int hostId) {
    _hostId = hostId;
    notifyListeners();
  }
}
