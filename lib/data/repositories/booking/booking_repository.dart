import '../../../model/bike_slot/bike_slot.dart';
import '../../../model/booking/booking.dart';
import '../../../model/station/station.dart';
import '../../../model/user/user.dart';

abstract class BookingRepository {
  Future<Booking> bookBike({
    required User user,
    required Station station,
    required BikeSlot slot,
  });

  Future<bool> hasActiveBookingAtStation({
    required String userId,
    required String stationId,
  });
}
