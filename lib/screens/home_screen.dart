import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          "assets/icons/bicycle.svg",
          color: Colors.black,
        ),
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Outfit Bold",
              style: TextStyle(
                fontFamily: "Outfit",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Work Sans Bold",
              style: TextStyle(
                fontFamily: "Work Sans",
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
