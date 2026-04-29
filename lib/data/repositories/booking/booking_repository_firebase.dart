import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/bike_slot/bike_slot.dart';
import '../../../model/booking/booking.dart';
import '../../../model/enums.dart';
import '../../../model/station/station.dart';
import '../../../model/user/user.dart';
import '../../dtos/booking_dto.dart';
import 'booking_repository.dart';

class BookingRepositoryFirebase implements BookingRepository {
  final String baseUrl = 'https://citybike-eb669-default-rtdb.firebaseio.com';

  @override
  Future<Booking> bookBike({
    required User user,
    required Station station,
    required BikeSlot slot,
  }) async {
    if (slot.status != SlotStatus.available || slot.bikeId == null) {
      throw StateError('Slot is not available.');
    }

    final bookingId = await _createBookingId();

    final booking = Booking(
      id: bookingId,
      station: station,
      slot: slot,
      bookedAt: DateTime.now(),
      status: BookingStatus.active,
    );

    final bookingDto = BookingDto.fromDomain(
      booking: booking,
      userId: user.id,
    );

    final bookingResponse = await http.put(
      Uri.parse('$baseUrl/bookings/${booking.id}.json'),
      body: jsonEncode(bookingDto.toJson()),
    );

    if (bookingResponse.statusCode < 200 || bookingResponse.statusCode >= 300) {
      throw Exception('Failed to create booking.');
    }

    final slotResponse = await http.patch(
      Uri.parse('$baseUrl/slots/${station.id}/${slot.id}.json'),
      body: jsonEncode({
        'status': SlotStatus.empty.name,
        'bikeId': null,
      }),
    );

    if (slotResponse.statusCode < 200 || slotResponse.statusCode >= 300) {
      throw Exception('Failed to update slot.');
    }

    return booking;
  }

  @override
  Future<bool> hasActiveBookingAtStation({
    required String userId,
    required String stationId,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/bookings.json'));
    if (response.statusCode != 200 || response.body == 'null') {
      return false;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data.values.any((booking) {
      return booking['userId'] == userId &&
          booking['stationId'] == stationId &&
          booking['status'] == BookingStatus.active.name;
    });
  }

  Future<String> _createBookingId() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings.json'));
    if (response.statusCode != 200 || response.body == 'null') {
      return 'booking_1';
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return 'booking_${data.length + 1}';
  }
}
