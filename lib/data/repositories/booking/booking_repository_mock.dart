import '../../../model/bike_slot/bike_slot.dart';
import '../../../model/booking/booking.dart';
import '../../../model/enums.dart';
import '../../../model/station/station.dart';
import '../../../model/user/user.dart';
import '../mock_bike_data_store.dart';
import 'booking_repository.dart';

class BookingRepositoryMock implements BookingRepository {
  final List<Booking> _bookings = [];
  final Map<String, String> _userIdByBookingId = {};

  @override
  Future<Booking> bookBike({
    required User user,
    required Station station,
    required BikeSlot slot,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (slot.status != SlotStatus.available || slot.bikeId == null) {
      throw StateError('Slot is not available.');
    }

    MockBikeDataStore.markSlotEmpty(
      stationId: station.id,
      slotId: slot.id,
    );

    final booking = Booking(
      id: 'booking_${_bookings.length + 1}',
      station: station,
      slot: slot,
      bookedAt: DateTime.now(),
      status: BookingStatus.active,
    );

    _bookings.add(booking);
    _userIdByBookingId[booking.id] = user.id;
    return booking;
  }

  @override
  Future<bool> hasActiveBookingAtStation({
    required String userId,
    required String stationId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return _bookings.any((booking) {
      return _userIdByBookingId[booking.id] == userId &&
          booking.station.id == stationId &&
          booking.status == BookingStatus.active;
    });
  }
}
