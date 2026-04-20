import 'package:flutter/material.dart';
import '../../../../data/repositories/station/station_repository.dart';
import '../../../../model/bike/bike.dart';
import '../../../../model/enums.dart';
import '../../../../model/station/station.dart';
import '../../../states/user_state.dart';
import '../../../states/pass_state.dart';
import '../../../utils/async_value.dart';

class StationDetailViewModel extends ChangeNotifier {
  // ── Dependencies (injected) ──────────────────────────────
  final StationRepository _stationRepository; //inject booking repo
  final UserState _userState;                 //inject auth state
  final PassState _passState;                 //inject pass state

  // ── Station passed from Map screen ──────────────────────
  final Station station; //passed via constructor/navigation

  // ── State ────────────────────────────────────────────────
  AsyncValue<List<BikeSlot>> _slots = AsyncValue.loading();
  AsyncValue<List<BikeSlot>> get slots => _slots;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isBooking = false;
  bool get isBooking => _isBooking;

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

  //Fetch bikes -> build free/occupied slot list
  Future<void> loadSlots() async {
    _slots = AsyncValue.loading();
    notifyListeners();

    try {
      //fetch bikes for this station from repo (Q11: VM → repo)
      final bikes = await _stationRepository.getBikesForStation(station.id);

      //generate slot list (Q8: free or occupied slots)
      final slotList = _generateSlots(bikes);

      //update state (Q11: → view)
      _slots = AsyncValue.success(slotList);
    } catch (e) {
      _slots = AsyncValue.error(e.toString());
    }

    notifyListeners(); //VM notifies the view
  }

  //Core logic — map bikes to BikeSlots
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
        // No bike in this physical slot -> Empty
        result.add(BikeSlot(
          slotNumber: i + 1,
          bikeType: null,
          status: SlotStatus.empty,
        ));
      }
    }

    return result;
  }

  //Rent a bike — checks PassState + UserState
  Future<bool> rentBike(BikeSlot slot) async {
    //user must have an active pass (PassState)
    if (!hasActivePass) {
      _errorMessage = 'You need an active pass to rent a bike.';
      notifyListeners();
      return false;
    }

    //user must be logged in (UserState)
    if (_userState.user == null) {
      _errorMessage = 'You must be logged in to rent a bike.';
      notifyListeners();
      return false;
    }

    //slot must be available
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
        _userState.user!.id,
      );
      await loadSlots(); // refresh slot list after booking
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