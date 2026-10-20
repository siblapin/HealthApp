import 'package:flutter/material.dart';


import '../../../core/constants/constants_exp.dart';

import '../settings_screen/settings_screen.dart';
import '../settings_screen/widgets/Input_of_Indicators_model.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorBackgroundApp().bg,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    const OutputSisDisPuls(),
                    // const GenderBottons(),
                    const SizedBox(height: 10),
                    const InfoWidgetsInput(),
                    const SizedBox(height: 20),
                    const InputOfIndicatorsSettings(),
                     const SizedBox(height: 10),
                    const ButtonUpdateResult(),
                    const SizedBox(height: 20),
                  
                 
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}