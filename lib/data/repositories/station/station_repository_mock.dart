import '../../../model/station/station.dart';
import '../mock_bike_data_store.dart';
import 'station_repository.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBikeDataStore.getStations();
  }

  @override
  Future<Station?> getStationById(String stationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MockBikeDataStore.getStationById(stationId);
  }
}
