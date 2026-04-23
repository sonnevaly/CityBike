import 'package:flutter/material.dart';
import 'package:citybike/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../../../model/station/station.dart';
import '../../../model/bike/bike.dart';
import '../../../data/repositories/station/station_repository.dart';
import '../../../ui/states/user_state.dart';
import '../../../ui/states/pass_state.dart';
import 'view_model/station_detail_view_model.dart';
import 'widgets/station_header.dart';
import 'widgets/availability_card.dart';
import 'widgets/slot_list.dart';
import 'widgets/bottom_buttons.dart';

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
          StationHeader(vm: vm),
          AvailabilityCard(vm: vm),
          Expanded(
            child: SlotList(
              vm: vm,
              onRent: _handleRent,
            ),
          ),
          const BottomButtons(),
        ],
      ),
    );
  }

  Future<void> _handleRent(
    BuildContext context,
    StationDetailViewModel vm,
    BikeSlot slot,
  ) async {
    if (!vm.hasActivePass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You need an active pass to rent a bike!',
            style: TextStyle(fontFamily: 'Outfit'),
          ),
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
        backgroundColor: success ? AppColors.primary : Colors.red,
      ),
    );
  }
}