import 'package:flutter/material.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../model/bike/bike.dart';
import '../../../../ui/screens/station_details/view_model/station_detail_view_model.dart';
import '../../../../ui/utils/async_value.dart';
import 'bike_slot_tile.dart';
import 'section_header.dart';

class SlotList extends StatelessWidget {
  final StationDetailViewModel vm;
  final Future<void> Function(BuildContext, StationDetailViewModel, BikeSlot) onRent;

  const SlotList({
    super.key,
    required this.vm,
    required this.onRent,
  });

  @override
  Widget build(BuildContext context) {
    switch (vm.slots.state) {
      case AsyncValueState.loading:
        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF2ECC71)),
        );

      case AsyncValueState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/warning.svg',
                width: 40,
                colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
              ),
              const SizedBox(height: 8),
              Text(
                'Error: ${vm.slots.error}',
                style: const TextStyle(fontFamily: 'Outfit'),
              ),
              TextButton(
                onPressed: vm.loadSlots,
                child: const Text(
                  'Retry',
                  style: TextStyle(fontFamily: 'Outfit', color: Color(0xFF2ECC71)),
                ),
              ),
            ],
          ),
        );

      case AsyncValueState.success:
        final data = vm.slots.data!;
        final available = data.where((s) => s.isAvailable).toList();
        final inUse = data.where((s) => !s.isAvailable && !s.isEmpty).toList();
        final empty = data.where((s) => s.isEmpty).toList();

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            if (vm.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vm.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),

            if (available.isNotEmpty) ...[
              SectionHeader(
                title: 'Available Now',
                count: '${available.length} Bikes',
                countColor: AppColors.primary,
              ),
              const SizedBox(height: 8),
              ...available.map((slot) => BikeSlotTile(
                    slot: slot,
                    isBooking: vm.isBooking,
                    onRent: () => onRent(context, vm, slot),
                  )),
              const SizedBox(height: 16),
            ],

            if (inUse.isNotEmpty) ...[
              SectionHeader(
                title: 'Currently In Use',
                count: '${inUse.length} Bikes',
                countColor: Colors.grey,
              ),
              const SizedBox(height: 8),
              ...inUse.map((slot) => BikeSlotTile(
                    slot: slot,
                    isBooking: false,
                    onRent: null,
                  )),
              const SizedBox(height: 16),
            ],

            if (empty.isNotEmpty) ...[
              SectionHeader(
                title: 'Empty Slots',
                count: '${empty.length} Slots',
                countColor: Colors.grey,
              ),
              const SizedBox(height: 8),
              ...empty.map((slot) => BikeSlotTile(
                    slot: slot,
                    isBooking: false,
                    onRent: null,
                  )),
            ],
          ],
        );
    }
  }
}