import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:host_visitor_connect/common/extensions/string_extensions.dart';

class ValidatorOnChanged extends Cubit<String> {
  ValidatorOnChanged() : super('');

  void validateFirstName(String input) {
    if (input.isEmpty) {
      emit('Please enter First Name');
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(input)) {
      emit('Please enter valid First Name');
    } else {
      emit('');
    }
  }

  void validateMidName(String input) {
    if (input.isEmpty) {
      emit('');
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(input)) {
      emit('Please enter valid Middle Name');
    } else {
      emit('');
    }
  }

  void validateLastName(String input) {
    if (input.isEmpty) {
      emit('Please enter Last Name');
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(input)) {
      emit('Please enter valid Last Name');
    } else {
      emit('');
    }
  }

  void validateMobile(String input, BuildContext context) {
    if (input.isEmpty) {
      emit('Please enter Mobile Number');
    } else if (!RegExp(r'[5-9][0-9]{9}').hasMatch(input)) {
      emit('Please enter valid Mobile Number');
    } else {
      emit('');
    }
  }

  void validateForeginMobile(String input, BuildContext context) {
    if (input.isEmpty) {
      emit('Please enter Mobile Number');
    } else if (!input.startsWith('+')) {
      emit('Please select country code');
    } else if (!RegExp(r'^[+]{1}(?:[0-9\-\\(\\)\\/.]\s?){6,15}[0-9]{1}$')
        .hasMatch(input)) {
      emit('Please enter valid Mobile Number');
    } else {
      emit('');
    }
  }

  void validateEmail(String input) {
    if (input.isEmpty) {
      emit('Please enter Email Id');
    } else if (!(EmailValidator.validate(input))) {
      emit('Please enter valid Email Id');
    } else {
      emit('');
    }
  }

  void validateAadhar(String aadhar) {
    if (aadhar.isEmpty) {
      emit('Please enter Aadhaar Number');
    } else if (!RegExp(r'^[2-9][0-9]{3}[0-9]{4}[0-9]{4}$')
        .hasMatch(aadhar.replaceAll(" ", ""))) {
      emit('Please enter valid Aadhaar Number');
    } else {
      emit('');
    }
  }

  void validateVoterCardNo(String voterId) {
    if (voterId.isEmpty) {
      emit('Please enter Voter Card Number');
    } else if (!RegExp(r"^[A-Z]{3}[0-9]{7}$")
        .hasMatch(voterId.replaceAll(" ", ""))) {
      emit('Please enter valid Voter Id');
    } else {
      emit('');
    }
  }

  void validatePincode(String pincode) {
    if (pincode.isEmpty) {
      emit('Please enter Pincode');
    } else if (!RegExp(r'[1-9][0-9]{5}').hasMatch(pincode)) {
      emit('Please enter valid Pincode');
    } else {
      emit('');
    }
  }

  void validateCity(String input) {
    if (input.isEmpty) {
      emit('City cannot be empty');
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(input)) {
      emit('Please enter valid City');
    } else {
      emit('');
    }
  }

  void validateArea(String input) {
    if (input.isEmpty) {
      emit('Area cannot be empty');
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(input)) {
      emit('Please enter valid Area');
    } else {
      emit('');
    }
  }

  void validateAddress(String input) {
    if (input.isEmpty) {
      emit('Address cannot be empty');
    } else if (!RegExp(r"$").hasMatch(input)) {
      emit('Please enter valid Address');
    } else {
      emit('');
    }
  }

  void validateLoginMobile(String input) {
    if (input.isEmpty) {
      emit('Please enter Mobile Number');
    } else if ((input.startsWith('0')) &&
        !RegExp(r'[0][5-9][0-9]{9}').hasMatch(input)) {
      emit('Please enter valid Mobile Number ');
    } else if (!(input.startsWith('0')) &&
        !RegExp(r'[5-9][0-9]{9}').hasMatch(input)) {
      emit('Please enter valid Mobile Number ');
    } else if (!RegExp(r'[5-9][0-9]{9}').hasMatch(input)) {
      emit('Please enter valid Mobile Number');
    } else {
      emit('');
    }
  }

  void validateAge({String? age1, String? age2}) {
    int value1 = (int.tryParse(age1 ?? '') ?? 0);
    int value2 = (int.tryParse(age2 ?? '') ?? 0);
    if (age1.isNullOrEmpty() || age2.isNullOrEmpty()) {
      emit('Other value cannot be empty');
    } else if (!(age1.isNullOrEmpty()) && !(age2.isNullOrEmpty())) {
      if (value1 >= value2) {
        emit('From value should be smaller than To value');
      } else {
        emit('');
      }
    } else {
      emit('');
    }
  }

  void validateFullName(String input) {
    String? name = input.trimRight();
    String? fullName = name.trimLeft();
    if (fullName.isNullOrEmpty()) {
      emit('Please enter Full Name');
    }
    if (!(fullName.isNullOrEmpty())) {
      int spaceCount = fullName.split(' ').length - 1;
      // Check if there are between 1 and 3 spaces
      if (spaceCount >= 1 && spaceCount <= 3) {
        emit('');
      } else if (spaceCount == 0) {
        emit('Atleast 1 space is required');
      } else if (spaceCount > 3) {
        emit('You cannot enter more than 3 spaces');
      }
    }
  }
}

class AgeValidationBloc extends Bloc<Map<String, String>, String?> {
  AgeValidationBloc() : super(null);

  Stream<String?> mapEventToState(Map<String, String> event) async* {
    final minAge = event['minAge'];
    final maxAge = event['maxAge'];

    if (minAge == '' && maxAge == '') {
      yield null;
    } else if (minAge == null && maxAge == null) {
      yield null;
    } else if (minAge == null ||
        minAge.isEmpty ||
        maxAge == null ||
        maxAge.isEmpty) {
      yield 'Both fields are required'; // Either field is empty
    } else {
      final min = int.tryParse(minAge);
      final max = int.tryParse(maxAge);

      if (min == null || max == null || max <= min) {
        yield 'Max age should be greater than min age'; // Max age is less than or equal to min age
      } else {
        yield null; // Validation passed
      }
    }
  }
}
