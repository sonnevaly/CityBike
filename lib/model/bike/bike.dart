// ============================================================
// BIKE MODEL
// Contains: Bike, BikeSlot, BikeType enum, BikeSlotStatus enum
// ============================================================

enum BikeType { standard, electric }

enum BikeSlotStatus { available, occupied, empty }

class Bike {
  final String id;
  final BikeType type;
  final bool isAvailable;

  Bike({
    required this.id,
    required this.type,
    required this.isAvailable,
  });
}

class BikeSlot {
  final int slotNumber;
  final BikeType? bikeType; // null if slot is empty
  final BikeSlotStatus status;

  BikeSlot({
    required this.slotNumber,
    this.bikeType,
    required this.status,
  });

  bool get isAvailable => status == BikeSlotStatus.available;
  bool get isEmpty => status == BikeSlotStatus.empty;
  bool get isOccupied => status == BikeSlotStatus.occupied;
}