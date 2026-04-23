import 'package:citybike/model/pass/pass.dart';

import 'pass_repository.dart';

class PassRepositoryMock implements PassRepository {
  @override
  Future<List<Pass>> getPasses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Pass(
        id: '1',
        title: 'Day Pass',
        price: 5,
        duration: '24 Hours',
        type: PassType.day,
      ),
      Pass(
        id: '2',
        title: 'Monthly Pass',
        price: 25,
        duration: '30 Days',
        type: PassType.monthly,
      ),
      Pass(
        id: '3',
        title: 'Annual Pass',
        price: 250,
        duration: '365 Days',
        type: PassType.annual,
      ),
    ];
  }
}
