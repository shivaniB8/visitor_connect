import 'package:flutter/material.dart';

class ReportVisitor extends ChangeNotifier {
  int? visitorId;
  int? reasonFk;
  String? reason;
  String? briefReason;

  Map<String, dynamic> get toJson {
    return {
      "aa1": visitorId,
      "aw6": reasonFk,
      "aw7": reason ?? "",
      "aw8": briefReason,
    };
  }
}
