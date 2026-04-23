import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.alertBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/warning.svg',
            width: 16,
            colorFilter: const ColorFilter.mode(
                AppColors.alertText, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Only one pass can be active at a time. Selecting a new pass will replace your current one.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.alertText,
                fontFamily: 'Work Sans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}