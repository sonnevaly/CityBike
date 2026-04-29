import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'package:citybike/ui/states/pass_state.dart';
import 'package:citybike/ui/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/pass_header.dart';
import 'widgets/pass_content.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<PassRepository>();
    final passState = context.read<PassState>();
    final userState = context.read<UserState>();

    return ChangeNotifierProvider(
      create: (_) => PassViewModel(
        repository: repository,
        passState: passState,
        userState: userState,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: const Column(
          children: [
            PassHeader(),
            Expanded(child: PassContent()),
          ],
        ),
      ),
    );
  }
}
