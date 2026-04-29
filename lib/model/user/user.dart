import '../booking/booking.dart';
import '../user_pass/user_pass.dart';

class User {
  final String id;
  final String name;
  final UserPass? activePass;
  final List<Booking> bookings;

  const User({
    required this.id,
    required this.name,
    this.activePass,
    this.bookings = const [],
  });
}
