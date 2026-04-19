import 'package:flutter/material.dart';
import '../../model/pass/pass.dart';

class UserState extends ChangeNotifier {
  Pass? _activePass;
  Pass? get activePass => _activePass;

  bool get hasActivePass => _activePass != null;

  void setActivePass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }
}