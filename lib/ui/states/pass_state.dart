import 'package:flutter/material.dart';
import '../../model/pass/pass.dart';

class PassState extends ChangeNotifier {
  Pass? _activePass;
  bool _isPassActive = false;

  Pass? get activePass => _activePass;
  bool get isPassActive => _isPassActive;

  // Called when "Activate Pass" is clicked in the UI
  void activatePass(Pass plan) {
    _activePass = plan;
    _isPassActive = true;
    notifyListeners();
  }
}