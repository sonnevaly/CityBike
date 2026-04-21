import 'package:citybike/model/pass/pass.dart';
import 'package:flutter/material.dart';

class PassState extends ChangeNotifier {
  Pass? _activePass;
  bool _isPassActive = false;

  Pass? get activePass => _activePass;
  bool get isPassActive => _isPassActive;

  void activatePass(Pass plan) {
    _activePass = plan;
    _isPassActive = true;
    notifyListeners();
  }
}
