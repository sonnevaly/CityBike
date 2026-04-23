import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:citybike/model/station/station.dart';

class StationDialog extends StatelessWidget {
  final Station station;
  const StationDialog({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name,
            style: AppTextStyles.sectionHeader.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.gray,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  station.address,
                  style: AppTextStyles.body.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 20,
                  child: const Icon(
                    Icons.directions_bike,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "2",
                            style: TextStyle(
                              color: AppColors.dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "/${station.totalSlots}",
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      "Bikes Available",
                      style: TextStyle(color: AppColors.gray, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Available",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                '/station-details',
                arguments: station,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.near_me_outlined, size: 18),
                const SizedBox(width: 8),
                Text(
                  "View All Bikes",
                  style: AppTextStyles.emphasizedBody.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
