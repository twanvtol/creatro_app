import 'package:creatro_app/models/user.dart';
import 'package:creatro_app/service/authentication_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  CreatroUser? _user;
  final AuthenticationService _authMethods = AuthenticationService();

  CreatroUser get getUser => _user!;

  Future<void> refreshData() async {
    CreatroUser user = await _authMethods.getCurrentUserData();
    _user = user;
    notifyListeners();
  }
}
