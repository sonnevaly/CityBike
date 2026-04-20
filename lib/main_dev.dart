import 'package:provider/provider.dart';
import 'main_common.dart';

// Repositories
import 'data/repositories/station/station_repository_mock.dart';
import 'data/repositories/pass/pass_repository_mock.dart';

// States (The separate Global States that keep the app clean)
import 'ui/states/user_state.dart';
import 'ui/states/pass_state.dart';
import 'ui/states/station_state.dart';

List<InheritedProvider> get devProviders {
  return [
    // Repositories
    Provider(create: (_) => StationRepositoryMock()),
    Provider(create: (_) => PassRepositoryMock()),

    // Global States (Modular = Clean)
    ChangeNotifierProvider(create: (_) => UserState()),    // Lead handles this
    ChangeNotifierProvider(create: (_) => PassState()),    // Member 1 handles this
    ChangeNotifierProvider(create: (_) => StationState()), // Member 2/3 handles this
  ];
}

void main() => mainCommon(devProviders);