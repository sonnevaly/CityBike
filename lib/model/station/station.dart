// lib/model/station/station.dart
class Station {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final int availableBikes;
  final int totalSlots;

  Station({required this.id, required this.name, required this.lat, 
           required this.lng, required this.availableBikes, required this.totalSlots});
}