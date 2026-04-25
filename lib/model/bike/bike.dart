import '../enums.dart';

enum BikeType { standard, electric }

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
  final BikeType? bikeType;
  final SlotStatus status;

  BikeSlot({
    required this.slotNumber,
    this.bikeType,
    required this.status,
  });

  bool get isAvailable => status == SlotStatus.available;
  bool get isEmpty => status == SlotStatus.empty;
  bool get isUnderMaintenance => status == SlotStatus.maintenance;
}