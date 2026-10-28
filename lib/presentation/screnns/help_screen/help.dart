import 'package:flutter/material.dart';

import '../../../core/constants/constants_exp.dart';

import '../settings_screen/settings_screen.dart';
import '../settings_screen/widgets/input_of_indicators_model.dart';
import 'widgets/button_save_pdf.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ColorBackgroundApp.bg,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: const [
            SizedBox(height: 20),
            OutputSisDisPuls(),
            SizedBox(height: 10),
            InfoWidgetsInput(),
            SizedBox(height: 20),
            InputOfIndicatorsSettings(),
            SizedBox(height: 10),
            ButtonUpdateResult(),
            SizedBox(height: 10),
            ButtonSavePdf(),
            SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}
