import 'package:citybike/model/pass/pass.dart';

abstract class PassRepository {
  Future<List<Pass>> getPasses();
}
