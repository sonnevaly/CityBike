import 'package:citybike/model/user_pass/user_pass.dart';
import 'package:flutter/material.dart';

class PassState extends ChangeNotifier {
  UserPass? _activePass;

  UserPass? get activePass => _activePass;

  bool get isPassActive {
    final pass = _activePass;
    if (pass == null) return false;
    return pass.expiresAt.isAfter(DateTime.now());
  }

  void activatePass(UserPass pass) {
    _activePass = pass;
    notifyListeners();
  }
}
