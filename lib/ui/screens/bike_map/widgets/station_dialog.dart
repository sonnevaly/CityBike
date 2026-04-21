import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:citybike/model/station/station.dart';

class StationDialog extends StatelessWidget {
  final Station station;

  const StationDialog({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.name, style: AppTextStyles.sectionHeader),
          Text(station.address, style: AppTextStyles.body),
          const SizedBox(height: 20),
          
          // Availability Box (Figma Style)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.directions_bike, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Member 3 used 'totalslots' in the model
                    Text("${station.totalSlots} Slots", 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text("Total Capacity", style: TextStyle(color: AppColors.gray, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Text("Station Info", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Button to Member 3's Detail Screen
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamed(
                context, 
                '/station-details', 
                arguments: station, // Passing the whole Station object
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.near_me_outlined),
                SizedBox(width: 10),
                Text("View All Bikes"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}