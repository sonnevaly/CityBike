import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository repository;
  final PassState passState;

  AsyncValue<List<Pass>> passPlans = AsyncValue.loading();
  Pass? selectedPlan;

  PassViewModel({required this.repository, required this.passState}) {
    _fetch();
  }

  Future<void> _fetch() async {
    passPlans = AsyncValue.loading();
    notifyListeners();
    try {
      final data = await repository.getPasses();
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

  bool activatePass() {
    if (selectedPlan == null) return false;

    final now = DateTime.now();
    DateTime expiry;
    switch (selectedPlan!.type) {
      case PassType.day:
        expiry = now.add(const Duration(days: 1));
        break;
      case PassType.monthly:
        expiry = now.add(const Duration(days: 30));
        break;
      case PassType.annual:
        expiry = now.add(const Duration(days: 365));
        break;
    }

    final passWithExpiry = Pass(
      id: selectedPlan!.id,
      title: selectedPlan!.title,
      price: selectedPlan!.price,
      duration: selectedPlan!.duration,
      type: selectedPlan!.type,
      expiryDate: expiry,
    );

    passState.activatePass(passWithExpiry);
    return true;
  }
}
