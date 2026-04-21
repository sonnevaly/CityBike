import 'package:flutter/material.dart';
import '../../../../model/bike/bike.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Slot ${slot.slotNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _statusLabel,
                  style: TextStyle(color: _statusColor, fontSize: 12),
                ),
              ],
            ),
          ),
          if (slot.isAvailable)
            isBooking
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : ElevatedButton(
                    onPressed: onRent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Rent'),
                  ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    switch (slot.status) {
      case SlotStatus.available:
        final icon = slot.bikeType == BikeType.electric
            ? Icons.electric_bike
            : Icons.pedal_bike;
        return Icon(icon, color: const Color(0xFF4CAF50), size: 28);
      case SlotStatus.empty:
        return const Icon(Icons.remove_circle_outline,
            color: Colors.grey, size: 28);
      case SlotStatus.maintenance:
        return const Icon(Icons.build_circle_outlined,
            color: Colors.orange, size: 28);
    }
  }

  String get _statusLabel {
    switch (slot.status) {
      case SlotStatus.available:
        return slot.bikeType == BikeType.electric
            ? 'Electric — Available'
            : 'Standard — Available';
      case SlotStatus.empty:
        return 'Empty Slot';
      case SlotStatus.maintenance:
        return 'Under Maintenance';
    }
  }

  Color get _statusColor {
    switch (slot.status) {
      case SlotStatus.available:
        return const Color(0xFF4CAF50);
      case SlotStatus.empty:
        return Colors.grey;
      case SlotStatus.maintenance:
        return Colors.orange;
    }
  }

  Color get _borderColor {
    switch (slot.status) {
      case SlotStatus.available:
        return const Color(0xFF4CAF50).withOpacity(0.4);
      case SlotStatus.empty:
        return Colors.grey.withOpacity(0.3);
      case SlotStatus.maintenance:
        return Colors.orange.withOpacity(0.4);
    }
  }
}