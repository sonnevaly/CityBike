import '../../../model/pass/pass.dart';
abstract class PassRepository {
  Future<List<Pass>> getAvailablePasses();
}