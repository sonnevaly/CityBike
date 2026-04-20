import 'package:flutter/material.dart';
import '../../model/station/station.dart';

class StationState extends ChangeNotifier {
  List<Station> _stations = [];
  List<Station> get stations => _stations;

  void setStations(List<Station> stations) {
    _stations = stations;
    notifyListeners();
  }
}