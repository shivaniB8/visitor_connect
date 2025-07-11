import 'package:flutter/material.dart';

class ReportSearch extends ChangeNotifier {
  String _serahcTerm = '';

  String get searchTerm => _serahcTerm;

  set searchTerm(String searchTerm) {
    _serahcTerm = searchTerm;
    notifyListeners();
  }
}
