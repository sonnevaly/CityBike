import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/ui/screens/bike_map/view_model/map_view_model.dart';
import 'package:citybike/ui/screens/bike_map/widgets/map_content.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapViewModel(
            repository: Provider.of<StationRepository>(context, listen: false),
          ),
        ),
      ],
      child: const Scaffold(body: MapContent()),
    );
  }
}
