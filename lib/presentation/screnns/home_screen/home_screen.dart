import 'package:flutter/material.dart';
import 'home_adroid.dart';
import 'home_web.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width > 950;

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? double.infinity : 400),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: isWide
                ? HomeScreenWeb(screenSize: screenSize)
                : const HomeScreenAndroid(),
          ),
        ),
      ),
    );
  }
}
