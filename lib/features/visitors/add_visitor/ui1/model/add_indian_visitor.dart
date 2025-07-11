import 'dart:core';
import 'package:flutter/widgets.dart';

class AddIndianVisitor extends ChangeNotifier {
  List<int>? ids = [];

  Map<dynamic, dynamic> get toJson {
    return {
      "aa1": ids ?? [],
    };
  }
}

class UpdateVisitorInfo extends ChangeNotifier {
  List<int>? visitorId = [];
  List<int>? historyIds = [];
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
  int? businessType;
  String? drivingLicenceNumber;
  String? passportNumber;

  Map<String, dynamic> get toJson {
    return {
      "aa1": visitorId,
      "ab1": historyIds,
      "aa36": briefReason,
      "aa48": reasonFk,
      "aa49": reason,
      "ab10": roomNo,
      "aa30": visitorType,
      "aa83": businessType,
      "aa41": passportNumber,
    };
  }
}

class AddForeignerVisitor extends ChangeNotifier {
  int? titleFk;
  String? title;
  String? fullName;
  String? dateOfBirth;
  String? mobileNumber;
  String? countryFk;
  String? countryName;
  String? countyCode;
  String? visitorExpireDateTime;
  String? visaNumber;
  String? visaExpiryDate;
  String? passportNumber;
  String? passportExpiryDate;
  String? mobileNumberCountryCode;
  int? gender;
  String? email;
  String? reason;
  int? reasonFk;
  int? bloodGrpFk;
  String? bloodGrpValue;
  String? otherReason;
  String? roomNo;
  int? businessType;

  Map<String, dynamic> get toJson {
    return {
      "aa4": titleFk,
      "aa5": title,
      "aa9": fullName,
      "aa10": dateOfBirth,
      "aa13": mobileNumber ?? '',
      "aa17": countryFk ?? 0,
      "aa18": countryName,
      "aa29": visitorExpireDateTime,
      "aa30": 2,
      "aa39": visaNumber,
      "aa40": visaExpiryDate,
      "aa41": passportNumber,
      "aa68": mobileNumberCountryCode,
      "aa72": passportExpiryDate,
      "aa12": gender,
      "aa14": email,
      "aa44": countyCode,
      "aa48": reasonFk,
      "aa49": reason,
      "aa78": bloodGrpFk,
      "aa79": bloodGrpValue,
      "aa36": otherReason,
      "ab10": roomNo,
      "aa83": businessType,
    };
  }
}
