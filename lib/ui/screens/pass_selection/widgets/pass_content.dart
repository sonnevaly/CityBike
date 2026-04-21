import 'package:citybike/ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pass_card.dart';

class PassContent extends StatelessWidget {
  const PassContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassViewModel>();
    final asyncValue = vm.passPlans;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: switch (asyncValue.state) {
              AsyncValueState.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              AsyncValueState.error => const Center(
                child: Text("Error loading passes"),
              ),
              AsyncValueState.success => ListView.builder(
                itemCount: asyncValue.data!.length,
                itemBuilder: (context, i) {
                  final plan = asyncValue.data![i];
                  return PassCard(
                    pass: plan,
                    isSelected: vm.selectedPlan == plan,
                    onTap: () => vm.selectPlan(plan),
                  );
                },
              ),
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/map');
            },
            child: const Text("Activate Pass"),
          ),
        ],
      ),
    );
  }
}
