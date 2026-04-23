import 'package:flutter/material.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: SvgPicture.asset(
                'assets/icons/mdi_location.svg',
                width: 16,
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
              ),
              label: const Text(
                'Back to Map',
                style: TextStyle(color: Colors.black54, fontFamily: 'Outfit'),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/icomoon-free_compass.svg',
                width: 16,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              label: const Text(
                'Get Direction',
                style: TextStyle(color: Colors.white, fontFamily: 'Outfit'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}