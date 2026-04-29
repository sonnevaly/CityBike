import 'package:citybike/model/pass/pass.dart';
import 'package:citybike/model/user_pass/user_pass.dart';

import 'pass_repository.dart';

class PassRepositoryMock implements PassRepository {
  UserPass? _activeUserPass;

  @override
  Future<List<Pass>> getPasses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Pass(id: 'day_pass', title: 'Day Pass', price: 5, durationDays: 1),
      const Pass(
        id: 'weekly_pass',
        title: 'Weekly Pass',
        price: 12,
        durationDays: 7,
      ),
      const Pass(
        id: 'monthly_pass',
        title: 'Monthly Pass',
        price: 25,
        durationDays: 30,
      ),
      const Pass(
        id: 'annual_pass',
        title: 'Annual Pass',
        price: 250,
        durationDays: 365,
      ),
    ];
  }

  @override
  Future<UserPass?> getActiveUserPass(String userId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final activePass = _activeUserPass;
    if (activePass == null) return null;
    if (activePass.expiresAt.isBefore(DateTime.now())) return null;

    return activePass;
  }

  @override
  Future<UserPass> activatePass({
    required String userId,
    required Pass pass,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final now = DateTime.now();
    final userPass = UserPass(
      id: 'user_pass_$userId',
      pass: pass,
      activatedAt: now,
      expiresAt: now.add(Duration(days: pass.durationDays)),
    );

    _activeUserPass = userPass;
    return userPass;
  }
}
