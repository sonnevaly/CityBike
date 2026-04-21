import 'package:flutter/material.dart';
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
    // Read from outer build context (guaranteed below MultiProvider via Builder)
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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Station Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _StationHeader(vm: vm),
          if (vm.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
          Expanded(child: _SlotList(vm: vm)),
        ],
      ),
    );
  }
}

class _StationHeader extends StatelessWidget {
  final StationDetailViewModel vm;
  const _StationHeader({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vm.station.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 14),
              const SizedBox(width: 4),
              Text(
                vm.station.address,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${vm.availableCount} / ${vm.totalSlots} bikes available',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                '${(vm.availabilityRatio * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _progressColor(vm.availabilityRatio),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: vm.availabilityRatio,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                _progressColor(vm.availabilityRatio),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _progressColor(double ratio) {
    if (ratio > 0.5) return const Color(0xFF4CAF50);
    if (ratio > 0.2) return Colors.orange;
    return Colors.red;
  }
}

class _SlotList extends StatelessWidget {
  final StationDetailViewModel vm;
  const _SlotList({required this.vm});

  @override
  Widget build(BuildContext context) {
    switch (vm.slots.state) {
      case AsyncValueState.success:
        final data = vm.slots.data!;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final slot = data[index];
            return BikeSlotTile(
              slot: slot,
              isBooking: vm.isBooking,
              onRent: slot.isAvailable
                  ? () => _handleRent(context, vm, slot)
                  : null,
            );
          },
        );
      case AsyncValueState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text('Error: ${vm.slots.error}'),
              TextButton(
                onPressed: vm.loadSlots,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());
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
          content: Text('You need an active pass to rent a bike!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await vm.rentBike(slot);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? '🚲 Bike rented successfully!' : 'Rental failed.'),
        backgroundColor: success ? const Color(0xFF4CAF50) : Colors.red,
      ),
    );
  }
}