import 'package:citybike/data/repositories/pass/pass_repository.dart';
import 'package:citybike/ui/screens/pass_selection/view_model/pass_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/pass_content.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          PassViewModel(repository: context.read<PassRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Choose your pass"),
          centerTitle: true,
        ),
        body: const PassContent(),
      ),
    );
  }
}
