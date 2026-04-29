import '../../../model/station/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
  Future<Station?> getStationById(String stationId);
}
