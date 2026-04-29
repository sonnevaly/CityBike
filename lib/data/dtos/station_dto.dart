import 'package:citybike/model/station/station.dart';
import 'package:citybike/model/bike_slot/bike_slot.dart';

class StationDto {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const StationDto({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory StationDto.fromJson(String id, Map<String, dynamic> json) {
    return StationDto(
      id: id,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Station toDomain({required List<BikeSlot> slots}) {
    return Station(
      id: id,
      name: name,
      address: address,
      latitude: latitude,
      longitude: longitude,
      slots: slots,
    );
  }
}
