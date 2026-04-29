import '../../model/bike_slot/bike_slot.dart';
import '../../model/enums.dart';
import '../../model/station/station.dart';

class MockBikeDataStore {
  static final Map<String, List<BikeSlot>> _slotsByStation = {
    'station_cadt': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_cadt_1',
      ),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_cadt_2',
      ),
      const BikeSlot(id: 'slot_3', slotNumber: 3, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_4',
        slotNumber: 4,
        status: SlotStatus.available,
        bikeId: 'bike_cadt_3',
      ),
      const BikeSlot(
        id: 'slot_5',
        slotNumber: 5,
        status: SlotStatus.available,
        bikeId: 'bike_cadt_4',
      ),
    ],
    'station_vattanac': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_vattanac_1',
      ),
      const BikeSlot(id: 'slot_2', slotNumber: 2, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_3',
        slotNumber: 3,
        status: SlotStatus.available,
        bikeId: 'bike_vattanac_2',
      ),
      const BikeSlot(
        id: 'slot_4',
        slotNumber: 4,
        status: SlotStatus.available,
        bikeId: 'bike_vattanac_3',
      ),
    ],
    'station_exchange_square': [
      const BikeSlot(id: 'slot_1', slotNumber: 1, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_exchange_1',
      ),
      const BikeSlot(
        id: 'slot_3',
        slotNumber: 3,
        status: SlotStatus.available,
        bikeId: 'bike_exchange_2',
      ),
      const BikeSlot(id: 'slot_4', slotNumber: 4, status: SlotStatus.empty),
    ],
    'station_royal_palace': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_palace_1',
      ),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_palace_2',
      ),
      const BikeSlot(id: 'slot_3', slotNumber: 3, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_4',
        slotNumber: 4,
        status: SlotStatus.available,
        bikeId: 'bike_palace_3',
      ),
    ],
    'station_central_market': [
      const BikeSlot(
        id: 'slot_1',
        slotNumber: 1,
        status: SlotStatus.available,
        bikeId: 'bike_market_1',
      ),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_market_2',
      ),
      const BikeSlot(
        id: 'slot_3',
        slotNumber: 3,
        status: SlotStatus.available,
        bikeId: 'bike_market_3',
      ),
      const BikeSlot(id: 'slot_4', slotNumber: 4, status: SlotStatus.empty),
    ],
    'station_aeon_1': [
      const BikeSlot(id: 'slot_1', slotNumber: 1, status: SlotStatus.empty),
      const BikeSlot(
        id: 'slot_2',
        slotNumber: 2,
        status: SlotStatus.available,
        bikeId: 'bike_aeon_1',
      ),
      const BikeSlot(
        id: 'slot_3',
        slotNumber: 3,
        status: SlotStatus.available,
        bikeId: 'bike_aeon_2',
      ),
      const BikeSlot(
        id: 'slot_4',
        slotNumber: 4,
        status: SlotStatus.available,
        bikeId: 'bike_aeon_3',
      ),
    ],
  };

  static List<Station> getStations() {
    return [
      Station(
        id: 'station_cadt',
        name: 'CADT Innovation Center',
        address: 'Bridge 2, National Road 6A, Phnom Penh',
        latitude: 11.6261,
        longitude: 104.9123,
        slots: getSlots('station_cadt'),
      ),
      Station(
        id: 'station_vattanac',
        name: 'Vattanac Capital',
        address: 'Monivong Boulevard, Phnom Penh',
        latitude: 11.5712,
        longitude: 104.9215,
        slots: getSlots('station_vattanac'),
      ),
      Station(
        id: 'station_exchange_square',
        name: 'Exchange Square',
        address: 'Street 106, Phnom Penh',
        latitude: 11.5745,
        longitude: 104.9230,
        slots: getSlots('station_exchange_square'),
      ),
      Station(
        id: 'station_royal_palace',
        name: 'Royal Palace',
        address: 'Samdach Sothearos Boulevard, Phnom Penh',
        latitude: 11.5633,
        longitude: 104.9310,
        slots: getSlots('station_royal_palace'),
      ),
      Station(
        id: 'station_central_market',
        name: 'Central Market',
        address: 'Kampuchea Krom Boulevard, Phnom Penh',
        latitude: 11.5696,
        longitude: 104.9210,
        slots: getSlots('station_central_market'),
      ),
      Station(
        id: 'station_aeon_1',
        name: 'AEON Mall Phnom Penh',
        address: 'Samdach Sothearos Boulevard, Phnom Penh',
        latitude: 11.5469,
        longitude: 104.9335,
        slots: getSlots('station_aeon_1'),
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
