import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String _phoneNo = '';
  String _branch = '';

  String get phoneNo => _phoneNo;
  String get branch => _branch;

  List<Contact> _contactList = [];

  List<Contact> get contactList => _contactList;

  set phoneNo(String phoneNo) {
    _phoneNo = phoneNo;
    notifyListeners();
  }

  set branch(String branch) {
    _branch = branch;
    notifyListeners();
  }

  set contact(List<Contact> list) {
    _contactList = list;
    notifyListeners();
  }
}
