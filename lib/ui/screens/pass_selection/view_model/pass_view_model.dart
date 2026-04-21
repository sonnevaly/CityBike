import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository repository;

  AsyncValue<List<Pass>> passPlans = AsyncValue.loading();
  Pass? selectedPlan;

  PassViewModel({required this.repository}) {
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
}
