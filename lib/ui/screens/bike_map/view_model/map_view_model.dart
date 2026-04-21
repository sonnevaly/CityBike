import 'package:flutter/material.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/model/station/station.dart';
import 'package:citybike/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository repository;
  AsyncValue<List<Station>> stationValue = AsyncValue.loading();

  MapViewModel({required this.repository}) {
    getStations();
  }

  void getStations() async {
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
}