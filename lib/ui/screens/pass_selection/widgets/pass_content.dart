import 'package:citybike/ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'active_pass_banner.dart';
import 'warning_banner.dart';
import 'pass_card.dart';
import 'pass_bottom_buttons.dart';

class PassContent extends StatelessWidget {
  const PassContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: switch (vm.passPlans.state) {
              AsyncValueState.loading => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              AsyncValueState.error => const Center(
                  child: Text('Error loading passes',
                      style: TextStyle(fontFamily: 'Outfit')),
                ),
              AsyncValueState.success => ListView(
                  children: [
                    if (vm.passState.isPassActive) ...[
                      ActivePassBanner(passState: vm.passState),
                      const SizedBox(height: 12),
                      const WarningBanner(),
                      const SizedBox(height: 16),
                    ],
                    ...vm.passPlans.data!.map((plan) => PassCard(
                          pass: plan,
                          isSelected: vm.selectedPlan == plan,
                          onTap: () => vm.selectPlan(plan),
                        )),
                  ],
                ),
            },
          ),
          const SizedBox(height: 12),
          PassBottomButtons(
            vm: vm,
            onActivate: () => _onActivate(context, vm),
          ),
        ],
      ),
    );
  }

  Future<void> _onActivate(BuildContext context, PassViewModel vm) async {
    final success = await vm.activatePass();

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
            const Icon(Icons.check_circle, color: AppColors.primary, size: 60),
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
              style: TextStyle(color: AppColors.primary, fontFamily: 'Outfit'),
            ),
          ),
        ],
      ),
    );
  }
}
