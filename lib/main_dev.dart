import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/data/repositories/pass/pass_repository_mock.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/data/repositories/station/station_repository_mock.dart';
import 'package:citybike/main_common.dart';
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/states/station_state.dart';
import 'package:citybike/ui/states/user_state.dart';
import 'package:provider/provider.dart';

List<InheritedProvider> get devProviders {
  return [

    Provider<StationRepository>(create: (_) => StationRepositoryMock()),
    Provider<PassRepository>(create: (_) => PassRepositoryMock()),

   
    ChangeNotifierProvider<UserState>(create: (_) => UserState()),
    ChangeNotifierProvider<PassState>(create: (_) => PassState()),
    ChangeNotifierProvider<StationState>(create: (_) => StationState()),
  ];
}

void main() {
  mainCommon(devProviders);
}
