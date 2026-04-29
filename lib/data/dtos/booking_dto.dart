import '../../model/bike_slot/bike_slot.dart';
import '../../model/booking/booking.dart';
import '../../model/enums.dart';
import '../../model/station/station.dart';

class BookingDto {
  final String id;
  final String userId;
  final String stationId;
  final String slotId;
  final String bikeId;
  final String bookedAt;
  final String status;

  const BookingDto({
    required this.id,
    required this.userId,
    required this.stationId,
    required this.slotId,
    required this.bikeId,
    required this.bookedAt,
    required this.status,
  });

  factory BookingDto.fromJson(String id, Map<String, dynamic> json) {
    return BookingDto(
      id: id,
      userId: json['userId'] ?? '',
      stationId: json['stationId'] ?? '',
      slotId: json['slotId'] ?? '',
      bikeId: json['bikeId'] ?? '',
      bookedAt: json['bookedAt'] ?? '',
      status: json['status'] ?? 'active',
    );
  }

  factory BookingDto.fromDomain({
    required Booking booking,
    required String userId,
  }) {
    return BookingDto(
      id: booking.id,
      userId: userId,
      stationId: booking.station.id,
      slotId: booking.slot.id,
      bikeId: booking.slot.bikeId ?? '',
      bookedAt: booking.bookedAt.toIso8601String(),
      status: booking.status.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'stationId': stationId,
      'slotId': slotId,
      'bikeId': bikeId,
      'bookedAt': bookedAt,
      'status': status,
    };
  }

  Booking toDomain({
    required Station station,
    required BikeSlot slot,
  }) {
    return Booking(
      id: id,
      station: station,
      slot: slot,
      bookedAt: DateTime.tryParse(bookedAt) ?? DateTime.now(),
      status: _parseStatus(status),
    );
  }

  BookingStatus _parseStatus(String value) {
    switch (value) {
      case 'completed':
        return BookingStatus.completed;
      case 'active':
      default:
        return BookingStatus.active;
    }
  }
}

