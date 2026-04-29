import '../../model/bike_slot/bike_slot.dart';
import '../../model/enums.dart';
import '../../model/station/station.dart';

class MockBikeDataStore {
  static final Map<String, List<BikeSlot>> _slotsByStation = {
    'station_1': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_1',
      ),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_2',
      ),
      const BikeSlot(id: 'slot_3', slotNumber: 3, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_4',
        slotNumber: 4,
        status: SlotStatus.available,
        bikeId: 'bike_3',
      ),
    ],
    'station_2': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_4',
      ),
      const BikeSlot(id: 'slot_2', slotNumber: 2, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_3',
        slotNumber: 3,
        status: SlotStatus.available,
        bikeId: 'bike_5',
      ),
    ],
    'station_3': [
      const BikeSlot(id: 'slot_1', slotNumber: 1, status: SlotStatus.empty),
      const BikeSlot(id: 'slot_2', slotNumber: 2, status: SlotStatus.empty),
    ],
  };

  static List<Station> getStations() {
    return [
      Station(
        id: 'station_1',
        name: 'CADT Innovation Center',
        address: 'Bridge 2, Prek Leap',
        latitude: 11.6261,
        longitude: 104.9123,
        slots: getSlots('station_1'),
      ),
      Station(
        id: 'station_2',
        name: 'Vattanac Capital',
        address: 'Monivong Blvd',
        latitude: 11.5712,
        longitude: 104.9215,
        slots: getSlots('station_2'),
      ),
      Station(
        id: 'station_3',
        name: 'Exchange Square',
        address: 'Street 106',
        latitude: 11.5745,
        longitude: 104.9230,
        slots: getSlots('station_3'),
      ),
    ];
  }

  static Station? getStationById(String stationId) {
    for (final station in getStations()) {
      if (station.id == stationId) return station;
    }
    return null;
  }

  static List<BikeSlot> getSlots(String stationId) {
    return List<BikeSlot>.from(_slotsByStation[stationId] ?? []);
  }

  static BikeSlot markSlotEmpty({
    required String stationId,
    required String slotId,
  }) {
    final slots = _slotsByStation[stationId];
    if (slots == null) {
      throw StateError('Station not found.');
    }

    final slotIndex = slots.indexWhere((slot) => slot.id == slotId);
    if (slotIndex == -1) {
      throw StateError('Slot not found.');
    }

    final slot = slots[slotIndex];
    if (slot.status != SlotStatus.available || slot.bikeId == null) {
      throw StateError('Slot is not available.');
    }

    final updatedSlot = BikeSlot(
      id: slot.id,
      slotNumber: slot.slotNumber,
      status: SlotStatus.empty,
    );
    slots[slotIndex] = updatedSlot;
    return updatedSlot;
  }
}

