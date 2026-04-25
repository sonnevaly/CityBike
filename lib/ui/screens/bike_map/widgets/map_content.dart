import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:citybike/ui/utils/async_value.dart';
import 'package:citybike/ui/screens/bike_map/view_model/map_view_model.dart';
import 'package:citybike/ui/screens/bike_map/widgets/station_marker.dart';
import 'package:citybike/model/station/station.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapViewModel>();
    final asyncValue = vm.stationValue;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );

      case AsyncValueState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 10),
              Text('Error: ${asyncValue.error}'),
              ElevatedButton(
                onPressed: vm.getStations,
                child: const Text("Retry"),
              ),
            ],
          ),
        );

      case AsyncValueState.success:
        final List<Station> stations = asyncValue.data!;
        final markers = stations
            .map(
              (s) => StationMarker.build(
                station: s,
                context: context,
                onTap: (station, ctx) => vm.onMarkerTapped(station, ctx),
              ),
            )
            .toSet();

        return Stack(
          children: [
            GoogleMap(
              onMapCreated: vm.onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(11.6261, 104.9123),
                zoom: 14,
              ),
              markers: markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  _buildCircleButton(
                    Icons.arrow_back,
                    () => Navigator.pushReplacementNamed(
                      context,
                      '/pass-selection',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _buildSearchBar()),
                  const SizedBox(width: 10),
                  _buildCircleButton(Icons.tune, () {}),
                ],
              ),
            ),
            Positioned(
              bottom: 110,
              right: 20,
              child: _buildCircleButton(
                Icons.my_location,
                () => vm.zoomToAllStations(),
                size: 56,
                iconColor: AppColors.primary,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: _buildCustomNavBar(context, vm),
            ),
          ],
        );
    }
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search stations...",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    IconData icon,
    VoidCallback onTap, {
    double size = 45,
    Color iconColor = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size * 0.5),
      ),
    );
  }

  Widget _buildCustomNavBar(BuildContext context, MapViewModel vm) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(
            Icons.directions_bike,
            "Map",
            AppColors.primary,
            true,
            onTap: () => vm.getStations(),
          ),
          _navItem(
            Icons.near_me_outlined,
            "Passes",
            AppColors.gray,
            false,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pass-selection');
            },
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    Color color,
    bool isActive, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Work Sans',
            ),
          ),
        ],
      ),
    );
  }
}
