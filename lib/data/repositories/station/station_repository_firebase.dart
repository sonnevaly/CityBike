import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:citybike/data/dtos/station_dto.dart';
import '../../dtos/bike_dto.dart'; // Assume you created this DTO
import 'package:citybike/model/station/station.dart';
import 'package:citybike/model/bike/bike.dart';
import 'station_repository.dart';

class StationRepositoryFirebase implements StationRepository {
  final String baseUrl = "https://citybike-eb669-default-rtdb.firebaseio.com";

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(Uri.parse('$baseUrl/stations.json'));
    if (response.statusCode != 200 || response.body == 'null') return [];

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data.entries.map((e) => StationDto.fromJson(e.key, e.value).toDomain()).toList();
  }

  @override
  Future<List<Bike>> getBikesForStation(String stationId) async {

    final response = await http.get(Uri.parse('$baseUrl/$stationId.json'));
    if (response.statusCode != 200 || response.body == 'null') return [];

    final Map<String, dynamic> data = jsonDecode(response.body);

    return data.entries.map((e) {
      return Bike(
        id: e.key,
        type: BikeType.standard,
        isAvailable: e.value['status'] == 'available',
      );
    }).toList();
  }


  

  @override
  Future<void> bookBike(String stationId, int slotNumber, String userId) async {
    final url = Uri.parse('$baseUrl/slots/$stationId/$slotNumber.json');
    await http.patch(url, body: jsonEncode({
      'status': 'empty',
      'reservedUserId': userId,
    }));
  }
}