import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final String _username = "Nidarshana";
  final String _password = "123456";
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Method to check if user is already logged in
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.containsKey('username');
    notifyListeners();
  }

  // Login and save username in local storage if successful
  Future<bool> login(String username, String password) async {
    if (username == _username && password == _password) {
      _isLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username); // Store username in storage
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  // Logout and clear username from local storage
  Future<void> logout() async {
    _isLoggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Remove username from storage
    notifyListeners();
  }
}
