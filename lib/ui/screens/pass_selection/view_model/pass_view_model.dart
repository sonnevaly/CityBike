import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/states/user_state.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository repository;
  final PassState passState;
  final UserState userState;

  AsyncValue<List<Pass>> passPlans = AsyncValue.loading();
  Pass? selectedPlan;

  PassViewModel({
    required this.repository,
    required this.passState,
    required this.userState,
  }) {
    _fetch();
  }

  Future<void> _fetch() async {
    passPlans = AsyncValue.loading();
    notifyListeners();
    try {
      final data = await repository.getPasses();
      final activePass = await repository.getActiveUserPass(_userId);
      if (activePass != null) {
        passState.activatePass(activePass);
      }
      passPlans = AsyncValue.success(data);
    } catch (e) {
      passPlans = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void selectPlan(Pass plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  Future<bool> activatePass() async {
    final plan = selectedPlan;
    if (plan == null) return false;

    final activePass = await repository.activatePass(
      userId: _userId,
      pass: plan,
    );
    passState.activatePass(activePass);
    return true;
  }

  String get _userId => userState.user?.id ?? 'user_1';
}
