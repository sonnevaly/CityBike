import 'package:citybike/ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PassBottomButtons extends StatelessWidget {
  final PassViewModel vm;
  final VoidCallback onActivate;

  const PassBottomButtons({
    super.key,
    required this.vm,
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    if (vm.passState.isPassActive) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                disabledForegroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Current Pass',
                style: TextStyle(fontFamily: 'Outfit'),
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/map'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 54),
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue to Map',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: vm.selectedPlan == null ? null : onActivate,
            child: const Text('Activate Pass',
                style: TextStyle(fontFamily: 'Outfit')),
          ),
        ),
      ],
    );
  }
}
