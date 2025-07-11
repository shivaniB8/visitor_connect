import 'package:flutter/cupertino.dart';

class CheckOutVisitor extends ChangeNotifier {
  String? checkOutDate;
  String? checkOutTime;

  CheckOutVisitor({this.checkOutDate, this.checkOutTime});

  Map<String, dynamic> get toJson {
    return {
      "ab7": {
        "checkOutDate": checkOutDate,
        "checkOutTime": checkOutTime,
      }
    };
  }
}
