class UpdateVisitor {
  int? visitorFk;
  String? fullName;
  String? email;
  int? fkTitle;
  String? title;
  String? profilePhoto;
  String? reason;
  int? reasonFk;
  String? roomNo;
  String? visaNumber;
  String? visaExpiryDate;
  int? gender;
  int? bloodGrpFk;
  String? bloodGrpValue;
  String? otherReason;
  String? dateOfBirth;
  int? visitorType;
  int? businessType;
  int? visitorId;

  Map<String, dynamic> get toJson {
    return {
      "ab1": visitorId,
      "aa1": visitorFk,
      "aa14": email,
      "aa9": fullName,
      "aa4": fkTitle,
      "aa5": title,
      "aa48": reasonFk,
      "aa49": reason,
      "ab10": roomNo,
      "aa39": visaNumber,
      "aa40": visaExpiryDate,
      "aa12": gender,
      "aa78": bloodGrpFk,
      "aa79": bloodGrpValue,
      "aa10": dateOfBirth,
      "aa36": otherReason,
      "aa30": visitorType,
      "aa83": businessType,
    };
  }
}
