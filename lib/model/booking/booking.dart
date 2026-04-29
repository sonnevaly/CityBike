import '../bike_slot/bike_slot.dart';
import '../enums.dart';
import '../station/station.dart';

class Booking {
  final String id;
  final Station station;
  final BikeSlot slot;
  final DateTime bookedAt;
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.station,
    required this.slot,
    required this.bookedAt,
    required this.status,
  });
}
