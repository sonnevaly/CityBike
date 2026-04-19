import '../../../model/pass/pass.dart';
import 'pass_repository.dart';

class PassRepositoryMock implements PassRepository {
  @override
  Future<List<Pass>> getAvailablePasses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Pass(id: '1', title: 'Day Pass', price: 5.0, duration: '24 hour', type: PassType.day),
      Pass(id: '2', title: 'Monthly Pass', price: 25.0, duration: '30 days', type: PassType.monthly),
    ];
  }
}