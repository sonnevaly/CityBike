import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:citybike/data/dtos/pass_dto.dart';
import 'package:citybike/model/pass/pass.dart';
import 'pass_repository.dart';

class PassRepositoryFirebase implements PassRepository {
  final String baseUrl = "https://citybike-eb669-default-rtdb.firebaseio.com";

  @override
  Future<List<Pass>> getPasses() async {
    final url = Uri.parse('$baseUrl/pass_plans.json');
    
    try {
      final response = await http.get(url);

      if (response.statusCode != 200 || response.body == 'null') {
        return [];
      }

      final Map<String, dynamic> data = jsonDecode(response.body);
      return data.entries.map((entry) {
        return PassDto.fromJson(entry.key, entry.value).toDomain();
      }).toList();
      
    } catch (e) {
      throw Exception("Failed to fetch passes from Firebase: $e");
    }
  }
}