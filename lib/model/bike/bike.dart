// lib/model/bike/bike.dart
class BikeSlot {
  final String id;
  final bool hasBike; // true = Available bike, false = Empty slot
  final String? bikeType; // 'Standard' or 'Electric'

  BikeSlot({required this.id, required this.hasBike, this.bikeType});
}