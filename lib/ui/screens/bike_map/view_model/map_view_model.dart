import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:citybike/data/repositories/station/station_repository.dart';
import 'package:citybike/model/station/station.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:citybike/ui/screens/bike_map/widgets/station_dialog.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository repository;
  AsyncValue<List<Station>> stationValue = AsyncValue.loading();

  GoogleMapController? _mapController;

  MapViewModel({required this.repository}) {
    getStations();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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

  void zoomToAllStations() {
    if (_mapController == null || stationValue.state != AsyncValueState.success)
      return;

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(target: LatLng(11.5900, 104.9123), zoom: 12.5),
      ),
    );
  }

  void onMarkerTapped(Station station, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StationDialog(
        station: station,
        onStationChanged: getStations,
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
