import 'dart:core';
import 'package:flutter/widgets.dart';

class AddIndianVisitor extends ChangeNotifier {
  String? mobileNumber;
  String? aadharNumber;
  int? id;
  Map<String, dynamic> get toJson {
    return {
      "aa1": id,
      "aa13": mobileNumber ?? '',
      "aa33": aadharNumber ?? "",
    };
  }
}

class UpdateVisitorInfo extends ChangeNotifier {
  int? visitorId;
  String? reason;
  String? briefReason;
  int? reasonFk;
  DateTime? visitingTill;
  DateTime? visitingFrom;
  DateTime? visaExpiry;
  String? visaNumber;
  String? mobileNumber;
  String? fullName;
  String? roomNo;
  int? visitorType;
  int? historyId;

  Map<String, dynamic> get toJson {
    return {
      "aa1": visitorId,
      "ab1": historyId,
      "aa13": mobileNumber,
      "aa36": briefReason ?? '',
      "aa42": visitingFrom,
      "aa43": visitingTill,
      "aa48": reasonFk,
      "aa49": reason,
      "aa39": visaNumber,
      "aa40": visaExpiry ?? "",
      "aa9": fullName,
      "ab10": roomNo,
      "aa30": visitorType,
    };
  }
}

class AddForeignerVisitor extends ChangeNotifier {
  String? mobileNumber;
  String? countyCode;
  String? countryFk;
  String? countryName;
  String? passportcountyCode;
  String? passportcountryFk;
  String? passportcountryName;
  String? passportNumber;
  String? dateOfBirth;
  String? passportExpiryDate;
  String? fullName;
  String? title;
  int? titleFk;
  int? gender;
  String? email;

  Map<String, dynamic> get toJson {
    return {
      "aa4": titleFk,
      "aa5": title,
      "aa9": fullName,
      "aa13": mobileNumber ?? '',
      "aa44": countyCode ?? "",
      "aa17": countryFk ?? 0,
      "aa18": countryName,
      "aa10": dateOfBirth,
      "aa41": passportNumber,
      "ap14": passportcountyCode,
      "ap15": passportcountryName,
      "ap16": passportExpiryDate,
      "ap17": passportcountryFk,
      "aa30": 2,
      "aa12": gender,
      "aa14": email,
    };
  }
}
