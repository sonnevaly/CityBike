import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PassCard extends StatelessWidget {
  final Pass pass;
  final bool isSelected;
  final VoidCallback onTap;

  const PassCard({
    super.key,
    required this.pass,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // Logic: Selected = Green Background, Unselected = White
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pass.title,
                  style: AppTextStyles.emphasizedBody.copyWith(
                    color: isSelected ? Colors.white : AppColors.dark,
                    fontSize: 18,
                  ),
                ),
                Text(
                  pass.duration,
                  style: AppTextStyles.body.copyWith(
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : AppColors.gray,
                  ),
                ),
              ],
            ),
            Text(
              "${pass.price.toInt()}\$",
              style: AppTextStyles.heading.copyWith(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
