import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:citybike/ui/screens/bike_map/view_model/map_view_model.dart';
import 'package:citybike/ui/screens/bike_map/widgets/station_marker.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapViewModel>();
    final asyncValue = vm.stationValue;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator(color: AppColors.primary));

      case AsyncValueState.error:
        return Center(child: Text('Error: ${asyncValue.error}'));

      case AsyncValueState.success:
        final stations = asyncValue.data!;

        // Generate markers for the map
        final markers = stations.map((s) => StationMarker.build(
          station: s,
          context: context,
          onTap: (station, ctx) => vm.onMarkerTapped(station, ctx),
        )).toSet();

        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(11.6261, 104.9123), // Default: Phnom Penh
            zoom: 14,
          ),
          markers: markers,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
        );
    }
  }
}