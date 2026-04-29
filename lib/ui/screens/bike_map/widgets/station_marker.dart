import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:citybike/model/enums.dart';
import 'package:citybike/model/station/station.dart';

class StationMarker {
  static Future<Marker> build({
    required Station station,
    required BuildContext context,
    required Function(Station, BuildContext) onTap,
  }) async {
    final availableBikes = station.slots.where((slot) {
      return slot.status == SlotStatus.available && slot.bikeId != null;
    }).length;

    final icon = await _buildCountIcon(
      count: availableBikes,
      color: _markerColor(availableBikes),
    );

    return Marker(
      markerId: MarkerId(station.id),
      position: LatLng(station.latitude, station.longitude),
      onTap: () => onTap(station, context),
      icon: icon,
      infoWindow: InfoWindow(
        title: station.name,
        snippet: '$availableBikes/${station.slots.length} bikes available',
      ),
    );
  }

  static Color _markerColor(int availableBikes) {
    if (availableBikes == 0) return const Color(0xFFEF4444);
    if (availableBikes <= 2) return const Color(0xFFF59E0B);
    return const Color(0xFF10B981);
  }

  static Future<BitmapDescriptor> _buildCountIcon({
    required int count,
    required Color color,
  }) async {
    const double size = 82;
    const double circleSize = 58;
    const double center = size / 2;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(
      const Offset(center, center + 3),
      circleSize / 2,
      shadowPaint,
    );

    final borderPaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      const Offset(center, center),
      circleSize / 2,
      borderPaint,
    );

    final fillPaint = Paint()..color = color;
    canvas.drawCircle(
      const Offset(center, center),
      (circleSize / 2) - 6,
      fillPaint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Outfit',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(center - textPainter.width / 2, center - textPainter.height / 2),
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }
}
