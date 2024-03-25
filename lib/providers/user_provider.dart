import 'package:courts_ecommerce/models/user.dart';
import 'package:courts_ecommerce/services/auth_service.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> login(String username, String password) async {
    try {
      _user = await _authService.login(username, password);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void updateUser({
    required String userID,
    required String username,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String homeAddress,
    required String password
  })
  {
    _user = User(
        userID:userID,
        username: username,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        homeAddress: homeAddress,
        password: password
    );
    notifyListeners();
  }

}