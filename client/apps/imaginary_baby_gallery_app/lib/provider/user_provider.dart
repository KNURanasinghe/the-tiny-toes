import 'package:flutter/material.dart';

import '../models/userModel.dart';
import '../services/NetworkService.dart';

class UserProvider with ChangeNotifier {
  final NetworkService _networkService = NetworkService();

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<User> get user => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _users = await _networkService.fetchUsers();
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }
}
