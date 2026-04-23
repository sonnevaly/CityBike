// ============================================================
// STATION REPOSITORY MOCK
// Simulates fetching stations and bikes from a local data source
// ============================================================

import '../../../model/bike/bike.dart';
import '../../../model/station/station.dart';
import 'station_repository.dart';

class StationRepositoryMock implements StationRepository {
  // Mock bike data per station
  final Map<String, List<Bike>> _bikesByStation = {
    'station_1': [
      Bike(id: 'b1', type: BikeType.standard, isAvailable: true),
      Bike(id: 'b2', type: BikeType.electric, isAvailable: true),
      Bike(id: 'b3', type: BikeType.standard, isAvailable: false),
    ],
    'station_2': [
      Bike(id: 'b4', type: BikeType.electric, isAvailable: true),
      Bike(id: 'b5', type: BikeType.standard, isAvailable: true),
    ],
    'station_3': [],
  };

  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Station(
        id: 'station_1',
        name: 'CADT Innovation Center',
        address: 'Bridge 2, Prek Leap',
        latitude: 11.6261, // Phnom Penh
        longitude: 104.9123, // Phnom Penh
        totalSlots: 14,
      ),
      Station(
        id: 'station_2',
        name: 'Vattanac Capital',
        address: 'Monivong Blvd',
        latitude: 11.5712, // Phnom Penh
        longitude: 104.9215, // Phnom Penh
        totalSlots: 20,
      ),
      Station(
        id: 'station_3',
        name: 'Exchange Square',
        address: 'Street 106',
        latitude: 11.5745, // Phnom Penh
        longitude: 104.9230, // Phnom Penh
        totalSlots: 15,
      ),
    ];
  }

  @override
  Future<List<Bike>> getBikesForStation(String stationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bikesByStation[stationId] ?? [];
  }

  @override
  Future<void> bookBike(String stationId, int slotNumber, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final bikes = _bikesByStation[stationId];
    if (bikes == null || slotNumber - 1 >= bikes.length) return;

    // Mark the bike as no longer available (occupied)
    final index = slotNumber - 1;
    final bike = bikes[index];
    bikes[index] = Bike(id: bike.id, type: bike.type, isAvailable: false);
  }
}
