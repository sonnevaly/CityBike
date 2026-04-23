import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citybike/model/station/station.dart';
import 'package:citybike/ui/screens/pass_selection/pass_screen.dart';
import 'package:citybike/ui/screens/bike_map/map_screen.dart';
import 'package:citybike/ui/screens/station_details/station_detail_screen.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const CityBikeApp()));
}

class CityBikeApp extends StatelessWidget {
  const CityBikeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CityBike',
      theme: appTheme,
      home: const PassScreen(),
      routes: {
        '/pass-selection': (context) => const PassScreen(),
        '/map': (context) => const MapScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/station-details') {
          final station = settings.arguments as Station;

          return MaterialPageRoute(
            builder: (context) => StationDetailScreen(station: station),
          );
        }
        return null;
      },
    );
  }
}
