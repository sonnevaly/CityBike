import '../../../model/station/station.dart';
import '../../../model/bike/bike.dart';
abstract class StationRepository {
  Future<List<Station>> getStations();
  Future<List<Bike>> getBikesForStation(String stationId);
  Future<void> bookBike(String stationId, int slotNumber, String userId);
}