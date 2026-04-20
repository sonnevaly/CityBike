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
        name: 'Central Park Station',
        address: '123 Central Ave',
        latitude: 48.8566,
        longitude: 2.3522,
        totalSlots: 5,
      ),
      Station(
        id: 'station_2',
        name: 'Riverside Station',
        address: '45 River Rd',
        latitude: 48.860,
        longitude: 2.358,
        totalSlots: 5,
      ),
      Station(
        id: 'station_3',
        name: 'Old Town Station',
        address: '7 Heritage St',
        latitude: 48.855,
        longitude: 2.349,
        totalSlots: 5,
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