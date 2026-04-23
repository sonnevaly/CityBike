import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:citybike/model/station/station.dart';

class StationMarker {
  static Marker build({
    required Station station,
    required BuildContext context,
    required Function(Station, BuildContext) onTap,
  }) {
    return Marker(
      markerId: MarkerId(station.id),
      // MATCHED: Used Member 3's variable names
      position: LatLng(station.latitude, station.longitude), 
      onTap: () => onTap(station, context),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
  }
}