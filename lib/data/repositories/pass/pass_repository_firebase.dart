import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:citybike/data/dtos/pass_dto.dart';
import 'package:citybike/data/dtos/user_pass_dto.dart';
import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/model/user_pass/user_pass.dart';
import 'pass_repository.dart';

class PassRepositoryFirebase implements PassRepository {
  final String baseUrl = "https://citybike-eb669-default-rtdb.firebaseio.com";

  @override
  Future<List<Pass>> getPasses() async {
    final url = Uri.parse('$baseUrl/passes.json');

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

  @override
  Future<UserPass?> getActiveUserPass(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user_passes/$userId.json'),
    );

    if (response.statusCode != 200 || response.body == 'null') {
      return null;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final userPassDto = UserPassDto.fromJson('user_pass_$userId', data);

    final passes = await getPasses();
    final matchingPasses = passes.where(
      (pass) => pass.id == userPassDto.passId,
    );
    if (matchingPasses.isEmpty) return null;

    final userPass = userPassDto.toDomain(matchingPasses.first);
    if (userPass.expiresAt.isBefore(DateTime.now())) return null;

    return userPass;
  }

  @override
  Future<UserPass> activatePass({
    required String userId,
    required Pass pass,
  }) async {
    final now = DateTime.now();
    final userPass = UserPass(
      id: 'user_pass_$userId',
      pass: pass,
      activatedAt: now,
      expiresAt: now.add(Duration(days: pass.durationDays)),
    );

    final dto = UserPassDto.fromDomain(userPass);
    final response = await http.put(
      Uri.parse('$baseUrl/user_passes/$userId.json'),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to activate pass.');
    }

    return userPass;
  }
}
