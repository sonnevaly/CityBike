import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Theme
import 'ui/theme/app_theme.dart';

// Repositories (Interface & Mock)
import 'data/repositories/pass/pass_repository_mock.dart';
import 'data/repositories/station/station_repository_mock.dart';

// ViewModels
import 'ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'ui/screens/bike_map/view_model/map_view_model.dart';
import 'ui/states/user_state.dart';

// Screens
import 'ui/screens/pass_selection/pass_screen.dart';

void main() {
  // Inject Mock Repositories
  // final passRepo = PassRepositoryMock();
  // final stationRepo = StationRepositoryMock();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()),
        // ChangeNotifierProvider(create: (_) => PassViewModel(passRepo)),
        // ChangeNotifierProvider(create: (_) => MapViewModel(stationRepo)),
      ],
      child: const VeloApp(),
    ),
  );
}

class VeloApp extends StatelessWidget {
  const VeloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const PassScreen(), // Member 1 will work on this
    );
  }
}