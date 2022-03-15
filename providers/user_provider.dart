import 'package:flutter/material.dart';

class UserToSave with ChangeNotifier {
  String _user = '';

  String get user => _user;

  void setUser(String email) {
    _user = email;
    notifyListeners();
  }
}