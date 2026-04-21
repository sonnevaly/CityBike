import 'package:citybike/ui/screens/bike_map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(MultiProvider(providers: providers, child: const CityBikeApp()));
}

class CityBikeApp extends StatelessWidget {
  const CityBikeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
      routes: {
        '/map': (context) => const MapScreen(), // Ensure MapScreen class exists
      },
    );
  }
}
