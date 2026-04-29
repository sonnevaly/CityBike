import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:citybike/data/dtos/bike_slot_dto.dart';
import 'package:citybike/data/dtos/station_dto.dart';
import 'package:citybike/model/bike_slot/bike_slot.dart';
import 'package:citybike/model/station/station.dart';
import 'station_repository.dart';

class StationRepositoryFirebase implements StationRepository {
  final String baseUrl = "https://citybike-eb669-default-rtdb.firebaseio.com";

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(Uri.parse('$baseUrl/stations.json'));
    if (response.statusCode != 200 || response.body == 'null') return [];

    final Map<String, dynamic> data = jsonDecode(response.body);
    final stations = <Station>[];

    for (final entry in data.entries) {
      final stationDto = StationDto.fromJson(entry.key, entry.value);
      final slots = await _getSlotsForStation(entry.key);
      stations.add(stationDto.toDomain(slots: slots));
    }

    return stations;
  }

  @override
  Future<Station?> getStationById(String stationId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stations/$stationId.json'),
    );
    if (response.statusCode != 200 || response.body == 'null') return null;

    final Map<String, dynamic> data = jsonDecode(response.body);
    final slots = await _getSlotsForStation(stationId);

    return StationDto.fromJson(stationId, data).toDomain(slots: slots);
  }

  Future<List<BikeSlot>> _getSlotsForStation(String stationId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/slots/$stationId.json'),
    );
    if (response.statusCode != 200 || response.body == 'null') return [];

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data.entries
        .map((entry) => BikeSlotDto.fromJson(entry.key, entry.value).toDomain())
        .toList()
      ..sort((a, b) => a.slotNumber.compareTo(b.slotNumber));
  }
}
