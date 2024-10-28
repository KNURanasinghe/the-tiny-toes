import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  // Hardcoded username and password
  final String _username = "Nidarshana";
  final String _password = "123456";

  // Track the login state
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Method to handle login
  bool login(String username, String password) {
    if (username == _username && password == _password) {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  // Method to handle logout
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
