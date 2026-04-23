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
            onPressed: vm.selectedPlan == null
                ? null
                : () => _onActivate(context, vm),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  Future<void> _onActivate(BuildContext context, PassViewModel vm) async {
    final success = vm.activatePass();

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a pass first!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF2ECC71), size: 60),
            const SizedBox(height: 12),
            const Text(
              'Pass Activated!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${vm.selectedPlan!.title} is now active.',
              style: const TextStyle(color: Colors.grey, fontFamily: 'Outfit'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/map');
            },
            child: const Text(
              'Go to Map',
              style: TextStyle(color: Color(0xFF2ECC71), fontFamily: 'Outfit'),
            ),
          ),
        ],
      ),
    );
  }
}
