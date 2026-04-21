import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/station/station.dart';
import '../../../data/repositories/station/station_repository.dart';
import '../../../ui/states/user_state.dart';
import '../../../ui/states/pass_state.dart';
import 'view_model/station_detail_view_model.dart';
import 'widgets/bike_slot_tile.dart';
import '../../../ui/utils/async_value.dart';
import '../../../model/bike/bike.dart';

class StationDetailScreen extends StatelessWidget {
  final Station station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<StationRepository>();
    final userState = context.read<UserState>();
    final passState = context.read<PassState>();

    return ChangeNotifierProvider(
      create: (_) => StationDetailViewModel(
        stationRepository: repo,
        userState: userState,
        passState: passState,
        station: station,
      ),
      child: const _StationDetailBody(),
    );
  }
}

class _StationDetailBody extends StatelessWidget {
  const _StationDetailBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationDetailViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          _GreenHeader(vm: vm),
          _AvailabilityCard(vm: vm),
          Expanded(child: _buildSlotList(context, vm)),
          _BottomButtons(),
        ],
      ),
    );
  }

  Widget _buildSlotList(BuildContext context, StationDetailViewModel vm) {
    switch (vm.slots.state) {
      case AsyncValueState.loading:
        return const Center(
            child: CircularProgressIndicator(color: Color(0xFF2ECC71)));

      case AsyncValueState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/warning.svg',
                  width: 40, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn)),
              const SizedBox(height: 8),
              Text('Error: ${vm.slots.error}',
                  style: const TextStyle(fontFamily: 'Outfit')),
              TextButton(
                onPressed: vm.loadSlots,
                child: const Text('Retry',
                    style: TextStyle(fontFamily: 'Outfit', color: Color(0xFF2ECC71))),
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
                child: Text(vm.errorMessage!,
                    style: const TextStyle(
                        color: Colors.red, fontSize: 13, fontFamily: 'Outfit')),
              ),

            if (available.isNotEmpty) ...[
              _SectionHeader(
                title: 'Available Now',
                count: '${available.length} Bikes',
                countColor: const Color(0xFF2ECC71),
              ),
              const SizedBox(height: 8),
              ...available.map((slot) => BikeSlotTile(
                    slot: slot,
                    isBooking: vm.isBooking,
                    onRent: () => _handleRent(context, vm, slot),
                  )),
              const SizedBox(height: 16),
            ],

            if (inUse.isNotEmpty) ...[
              _SectionHeader(
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
              _SectionHeader(
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

  Future<void> _handleRent(
    BuildContext context,
    StationDetailViewModel vm,
    BikeSlot slot,
  ) async {
    if (!vm.hasActivePass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You need an active pass to rent a bike!',
              style: TextStyle(fontFamily: 'Outfit')),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await vm.rentBike(slot);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? '🚲 Bike rented successfully!' : 'Rental failed.',
          style: const TextStyle(fontFamily: 'Outfit'),
        ),
        backgroundColor: success ? const Color(0xFF2ECC71) : Colors.red,
      ),
    );
  }
}

// ── Green Header ──────────────────────────────────────────────
class _GreenHeader extends StatelessWidget {
  final StationDetailViewModel vm;
  const _GreenHeader({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      color: const Color(0xFF2ECC71),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            vm.station.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/mdi_location.svg',
                width: 14,
                height: 14,
                colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  vm.station.address,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontFamily: 'Outfit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Availability Card ─────────────────────────────────────────
class _AvailabilityCard extends StatelessWidget {
  final StationDetailViewModel vm;
  const _AvailabilityCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/icons/bicycle.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF2ECC71), BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${vm.availableCount}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit',
                          ),
                        ),
                        TextSpan(
                          text: '/${vm.totalSlots}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Bikes Available',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Outfit'),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF2ECC71)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Available',
                  style: TextStyle(
                    color: Color(0xFF2ECC71),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Availability',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'Outfit')),
              Text(
                '${(vm.availabilityRatio * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: vm.availabilityRatio,
              minHeight: 8,
              backgroundColor: Colors.grey.shade100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String count;
  final Color countColor;

  const _SectionHeader({
    required this.title,
    required this.count,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: Colors.black87,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: countColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count,
            style: TextStyle(
              color: countColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ],
    );
  }
}

// ── Bottom Buttons ────────────────────────────────────────────
class _BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: SvgPicture.asset(
                'assets/icons/mdi_location.svg',
                width: 16,
                colorFilter:
                    const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
              ),
              label: const Text('Back to Map',
                  style: TextStyle(
                      color: Colors.black54, fontFamily: 'Outfit')),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/icomoon-free_compass.svg',
                width: 16,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              label: const Text('Get Direction',
                  style: TextStyle(color: Colors.white, fontFamily: 'Outfit')),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}