import 'package:citybike/model/station/station.dart';

class StationDto {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int totalSlots;

  StationDto({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSlots,
  });

  factory StationDto.fromJson(String id, Map<String, dynamic> json) {
    return StationDto(
      id: id,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      totalSlots: json['totalSlots'] ?? 0,
    );
  }

  Station toDomain() {
    return Station(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      totalSlots: totalSlots,
    );
  }
}
