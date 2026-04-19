import '../../../model/station/station.dart';
import 'station_repository.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getAllStations() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Station(id: '1', name: 'CADT Station', lat: 11.55, lng: 104.92, availableBikes: 10, totalSlots: 15),
    ];
  }
}