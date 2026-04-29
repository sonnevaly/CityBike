import 'package:flutter/material.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../model/bike_slot/bike_slot.dart';
import '../../../../model/enums.dart';

class BikeSlotTile extends StatelessWidget {
  final BikeSlot slot;
  final VoidCallback? onRent;
  final bool isBooking;

  const BikeSlotTile({
    super.key,
    required this.slot,
    this.onRent,
    this.isBooking = false,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable =
        slot.status == SlotStatus.available && slot.bikeId != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.primary.withOpacity(0.06)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isAvailable
              ? AppColors.primary.withOpacity(0.3)
              : Colors.grey.shade200,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isAvailable
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                'assets/icons/bicycle.svg',
                colorFilter: ColorFilter.mode(
                  isAvailable ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Bike info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _bikeLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                    color: isAvailable ? Colors.black87 : Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SvgPicture.asset(
                      isAvailable
                          ? 'assets/icons/mdi_tick.svg'
                          : 'assets/icons/wrong_tick.svg',
                      width: 12,
                      height: 12,
                      colorFilter: ColorFilter.mode(
                        isAvailable
                            ? AppColors.primary
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _statusLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Outfit',
                        color: isAvailable
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Rent button or slot number
          if (isAvailable && onRent != null)
            isBooking
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Color(0xFF2ECC71)),
                  )
                : GestureDetector(
                    onTap: onRent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Rent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  )
          else
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isAvailable
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${slot.slotNumber}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Outfit',
                    color: isAvailable
                        ? AppColors.primary
                        : Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String get _bikeLabel {
    switch (slot.status) {
      case SlotStatus.available:
        return 'Bike Slot ${slot.slotNumber}';
      case SlotStatus.empty:
        return 'Empty Slot ${slot.slotNumber}';
    }
  }

  String get _statusLabel {
    switch (slot.status) {
      case SlotStatus.available:
        return 'Available';
      case SlotStatus.empty:
        return 'Empty';
    }
  }
}
