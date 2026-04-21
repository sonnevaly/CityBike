import 'package:flutter/material.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/model/station/station.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:citybike/ui/screens/bike_map/widgets/station_dialog.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository repository;
  AsyncValue<List<Station>> stationValue = AsyncValue.loading();

  MapViewModel({required this.repository}) {
    getStations();
  }

  Future<void> getStations() async {
    stationValue = AsyncValue.loading();
    notifyListeners();
    try {
      final stations = await repository.getStations();
      stationValue = AsyncValue.success(stations);
    } catch (e) {
      stationValue = AsyncValue.error(e.toString());
    }
    notifyListeners();
  }

  void onMarkerTapped(Station station, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StationDialog(station: station),
    );
  }
}
