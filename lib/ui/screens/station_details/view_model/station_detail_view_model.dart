import 'package:flutter/material.dart';
import '../../../../data/repositories/station/station_repository.dart';
import '../../../../model/bike/bike.dart';
import '../../../../model/enums.dart';
import '../../../../model/station/station.dart';
import '../../../states/user_state.dart';
import '../../../states/pass_state.dart';
import '../../../utils/async_value.dart';

class StationDetailViewModel extends ChangeNotifier {
  final StationRepository _stationRepository;
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

  int get availableCount =>
      _slots.data?.where((s) => s.isAvailable).length ?? 0;

  int get totalSlots => station.totalSlots;

  double get availabilityRatio =>
      totalSlots == 0 ? 0 : availableCount / totalSlots;

  StationDetailViewModel({
    required StationRepository stationRepository,
    required UserState userState,
    required PassState passState,
    required this.station,
  })  : _stationRepository = stationRepository,
        _userState = userState,
        _passState = passState {
    loadSlots();
  }

  Future<void> loadSlots() async {
    _slots = AsyncValue.loading();
    notifyListeners();

    try {
      final bikes = await _stationRepository.getBikesForStation(station.id);
      final slotList = _generateSlots(bikes);
      _slots = AsyncValue.success(slotList);
    } catch (e) {
      _slots = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }

  List<BikeSlot> _generateSlots(List<Bike> bikes) {
    final List<BikeSlot> result = [];

    for (int i = 0; i < totalSlots; i++) {
      if (i < bikes.length) {
        final bike = bikes[i];
        result.add(BikeSlot(
          slotNumber: i + 1,
          bikeType: bike.type,
          status: bike.isAvailable
              ? SlotStatus.available
              : SlotStatus.empty,
        ));
      } else {
        result.add(BikeSlot(
          slotNumber: i + 1,
          bikeType: null,
          status: SlotStatus.empty,
        ));
      }
    }

    return result;
  }

  Future<bool> rentBike(BikeSlot slot) async {
    // Block if already rented at this station
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

    // if (_userState.user == null) {
    //   _errorMessage = 'You must be logged in to rent a bike.';
    //   notifyListeners();
    //   return false;
    // }

    if (!slot.isAvailable) {
      _errorMessage = 'This slot is not available.';
      notifyListeners();
      return false;
    }

    _isBooking = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _stationRepository.bookBike(
        station.id,
        slot.slotNumber,
        '1'
      );
      _hasRented = true; //Mark as rented
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
}