import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  final String _defaultUsername = "Nidarshana";
  final String _defaultPassword = "123456";
  bool _isLoggedIn = false;
  String? _username;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;

 
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username')) {
      _isLoggedIn = true;
      _username = prefs.getString('username');
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }


  Future<bool> login(String username, String password) async {
    if (username == _defaultUsername && password == _defaultPassword) {
      _isLoggedIn = true;
      _username = username;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username); 
      notifyListeners();
      return true;
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

 
  Future<void> logout() async {
    _isLoggedIn = false;
    _username = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); 
    notifyListeners();
  }
}
