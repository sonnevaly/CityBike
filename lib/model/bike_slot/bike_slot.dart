import '../enums.dart';

class BikeSlot {
  final String id;
  final int slotNumber;
  final SlotStatus status;
  final String? bikeId;

  const BikeSlot({
    required this.id,
    required this.slotNumber,
    required this.status,
    this.bikeId,
  });
}
