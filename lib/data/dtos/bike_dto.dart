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
    return {
      'slotNumber': slotNumber,
      'status': status,
      'bikeType': bikeType,
    };
  }
}