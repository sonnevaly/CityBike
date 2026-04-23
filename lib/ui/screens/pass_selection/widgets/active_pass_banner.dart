import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ActivePassBanner extends StatelessWidget {
  final PassState passState;
  const ActivePassBanner({super.key, required this.passState});

  int get _totalDays {
    switch (passState.activePass?.type) {
      case PassType.day:
        return 1;
      case PassType.monthly:
        return 30;
      case PassType.annual:
        return 365;
      default:
        return 30;
    }
  }

  int get _remainingDays {
    final expiry = passState.activePass?.expiryDate;
    if (expiry == null) return 0;
    final remaining = expiry.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  double get _progress {
    if (_totalDays == 0) return 0;
    return _remainingDays / _totalDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Current Active Pass',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Work Sans',
                fontSize: 13,
                color: AppColors.gray,
              ),
              children: [
                const TextSpan(text: 'You have an active '),
                TextSpan(
                  text: passState.activePass?.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: AppColors.lightGray,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 6),

          Text(
            '$_remainingDays days remaining',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.gray,
              fontFamily: 'Work Sans',
            ),
          ),
        ],
      ),
    );
  }
}
