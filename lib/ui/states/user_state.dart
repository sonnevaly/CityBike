import 'package:flutter/material.dart';
import '../../model/user/user.dart';

class UserState extends ChangeNotifier {
  User? _user = const User(id: 'user_1', name: 'Demo User');
  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
