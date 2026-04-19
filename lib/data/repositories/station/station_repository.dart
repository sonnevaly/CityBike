import '../../../model/station/station.dart';
abstract class StationRepository {
  Future<List<Station>> getAllStations();
}