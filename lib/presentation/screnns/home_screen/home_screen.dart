import 'package:flutter/material.dart';
import 'home_adroid.dart';
import 'home_web.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
        width: (screenSize.width < 950) ? 400 : double.infinity,
        child: (screenSize.width > 950)
            ? HomeScreenWeb(screenSize: screenSize,)
            : HomeScreenAndroid()
      ),
    );
  }
}


