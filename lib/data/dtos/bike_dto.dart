import "../../model/bike/bike.dart";
import "../../model/enums.dart";

class BikeSlotDto {
  final String id;
  final int slotNumber;
  final String status;
  final String? bikeType;

  BikeSlotDto({
    required this.id,
    required this.slotNumber,
    required this.status,
    this.bikeType,
  });

  factory BikeSlotDto.fromJson(String id, Map<String, dynamic> json) {
    return BikeSlotDto(
      id: id,
      slotNumber: json['slotNumber'] ?? 0,
      status: json['status'] ?? 'empty',
      bikeType: json['bikeType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'slotNumber': slotNumber, 'status': status, 'bikeType': bikeType};
  }

  BikeSlot toDomain() {
    return BikeSlot(
      slotNumber: slotNumber,
      bikeType: _parseBikeType(bikeType),
      status: _parseStatus(status),
    );
  }

  BikeType? _parseBikeType(String? type) {
    if (type == 'standard') return BikeType.standard;
    if (type == 'electric') return BikeType.electric;
    return null;
  }

  SlotStatus _parseStatus(String statusStr) {
    switch (statusStr) {
      case 'available':
        return SlotStatus.available;
      case 'maintenance':
        return SlotStatus.maintenance;
      default:
        return SlotStatus.empty;
    }
  }
}
