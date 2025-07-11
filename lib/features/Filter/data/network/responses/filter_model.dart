import 'package:flutter/cupertino.dart';

class FiltersModel extends ChangeNotifier {
  final String? searchTerm;
  final String? ageFilter;
  final String? agemin;
  final String? agemax;
  final List<int>? genderFilter;
  final String? pincodeFilter;
  final String? aadharNo;
  final String? visaNumber;
  final String? state;
  String? pinCode;
  int? stateFk;
  String? stateValue;
  int? cityFk;
  String? cityValue;
  int? areaFk;
  String? areaValue;
  int? userStatus;

  FiltersModel(
      {this.searchTerm,
      this.ageFilter,
      this.agemin,
      this.agemax,
      this.genderFilter,
      this.pincodeFilter,
      this.aadharNo,
      this.visaNumber,
      this.state,
      this.areaFk,
      this.areaValue,
      this.stateFk,
      this.stateValue,
      this.cityFk,
      this.cityValue,
      this.userStatus,
      this.pinCode});
}
