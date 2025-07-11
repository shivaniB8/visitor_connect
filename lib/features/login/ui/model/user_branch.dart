import 'dart:core';
import 'package:flutter/widgets.dart';

class UserBranch extends ChangeNotifier {
  int? branchId;
  String? branchName;
  String? phoneNumber;

  Map<String, dynamic> get toJson {
    return {
      "ae1": branchId,
      "ae5": branchName,
      "login_id": phoneNumber,
    };
  }
}
