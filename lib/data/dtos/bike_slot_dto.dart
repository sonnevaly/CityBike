import '../../model/bike_slot/bike_slot.dart';
import '../../model/enums.dart';

class BikeSlotDto {
  final String id;
  final int slotNumber;
  final String status;
  final String? bikeId;

  const BikeSlotDto({
    required this.id,
    required this.slotNumber,
    required this.status,
    this.bikeId,
  });

  factory BikeSlotDto.fromJson(String id, Map<String, dynamic> json) {
    return BikeSlotDto(
      id: id,
      slotNumber: json['slotNumber'] ?? 0,
      status: json['status'] ?? 'empty',
      bikeId: json['bikeId'],
    );
  }

  factory BikeSlotDto.fromDomain(BikeSlot slot) {
    return BikeSlotDto(
      id: slot.id,
      slotNumber: slot.slotNumber,
      status: slot.status.name,
      bikeId: slot.bikeId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotNumber': slotNumber,
      'status': status,
      'bikeId': bikeId,
    };
  }

  BikeSlot toDomain() {
    return BikeSlot(
      id: id,
      slotNumber: slotNumber,
      status: _parseStatus(status),
      bikeId: bikeId,
    );
  }

  SlotStatus _parseStatus(String value) {
    switch (value) {
      case 'available':
        return SlotStatus.available;
      case 'empty':
      default:
        return SlotStatus.empty;
    }
  }
}

