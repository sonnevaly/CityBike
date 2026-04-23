import 'package:flutter/material.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../ui/screens/station_details/view_model/station_detail_view_model.dart';

class StationHeader extends StatelessWidget {
  final StationDetailViewModel vm;
  const StationHeader({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            vm.station.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/mdi_location.svg',
                width: 14,
                height: 14,
                colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  vm.station.address,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}