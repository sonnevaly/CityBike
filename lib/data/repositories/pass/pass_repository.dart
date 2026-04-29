import '../../../model/pass/pass.dart';
import '../../../model/user_pass/user_pass.dart';

abstract class PassRepository {
  Future<List<Pass>> getPasses();

  Future<UserPass?> getActiveUserPass(String userId);

  Future<UserPass> activatePass({
    required String userId,
    required Pass pass,
  });
}
