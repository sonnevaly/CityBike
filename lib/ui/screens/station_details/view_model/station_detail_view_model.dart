import 'package:flutter/material.dart';
import '../../../../data/repositories/booking/booking_repository.dart';
import '../../../../data/repositories/station/station_repository.dart';
import '../../../../model/bike_slot/bike_slot.dart';
import '../../../../model/enums.dart';
import '../../../../model/station/station.dart';
import '../../../../model/user/user.dart';
import '../../../states/user_state.dart';
import '../../../states/pass_state.dart';
import '../../../utils/async_value.dart';

class StationDetailViewModel extends ChangeNotifier {
  final StationRepository _stationRepository;
  final BookingRepository _bookingRepository;
  final UserState _userState;
  final PassState _passState;
  final Station station;

  AsyncValue<List<BikeSlot>> _slots = AsyncValue.loading();
  AsyncValue<List<BikeSlot>> get slots => _slots;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isBooking = false;
  bool get isBooking => _isBooking;

  //One bike per station visit
  bool _hasRented = false;
  bool get hasRented => _hasRented;

  bool get hasActivePass => _passState.isPassActive;

  int get availableCount {
    return _slots.data?.where(_isSlotAvailable).length ?? 0;
  }

  int get totalSlots => _slots.data?.length ?? station.slots.length;

  double get availabilityRatio =>
      totalSlots == 0 ? 0 : availableCount / totalSlots;

  StationDetailViewModel({
    required StationRepository stationRepository,
    required BookingRepository bookingRepository,
    required UserState userState,
    required PassState passState,
    required this.station,
  })  : _stationRepository = stationRepository,
        _bookingRepository = bookingRepository,
        _userState = userState,
        _passState = passState {
    loadSlots();
  }

  Future<void> loadSlots() async {
    _slots = AsyncValue.loading();
    notifyListeners();

    try {
      final latestStation = await _stationRepository.getStationById(station.id);
      _slots = AsyncValue.success(latestStation?.slots ?? station.slots);
    } catch (e) {
      _slots = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }

  Future<bool> rentBike(BikeSlot slot) async {
    if (_hasRented) {
      _errorMessage = 'You already rented a bike at this station.';
      notifyListeners();
      return false;
    }

    if (!hasActivePass) {
      _errorMessage = 'You need an active pass to rent a bike.';
      notifyListeners();
      return false;
    }

    if (!_isSlotAvailable(slot)) {
      _errorMessage = 'This slot is not available.';
      notifyListeners();
      return false;
    }

    _isBooking = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = _userState.user ?? const User(id: 'user_1', name: 'Demo User');
      final alreadyBooked = await _bookingRepository.hasActiveBookingAtStation(
        userId: user.id,
        stationId: station.id,
      );

      if (alreadyBooked) {
        _errorMessage = 'You already rented a bike at this station.';
        return false;
      }

      await _bookingRepository.bookBike(
        user: user,
        station: station,
        slot: slot,
      );
      _hasRented = true;
      await loadSlots();
      return true;
    } catch (e) {
      _errorMessage = 'Booking failed. Please try again.';
      notifyListeners();
      return false;
    } finally {
      _isBooking = false;
      notifyListeners();
    }
  }

  bool _isSlotAvailable(BikeSlot slot) {
    return slot.status == SlotStatus.available && slot.bikeId != null;
  }
}
