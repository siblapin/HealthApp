import 'package:flutter/material.dart';

import '../../../../core/constants/constants_color.dart';
import '../../add_results_screen/add_bottom_sheet.dart';

class ButtonAddHomeScreen extends StatelessWidget {
  const ButtonAddHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp().color_100)),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) => AddBottomSheet(
              navigarotPop: true,
            ),
          );
        },
        icon: Icon(Icons.add_circle, color: ColorBackgroundApp().bg),
        label: Text(
          "Добавить",
          style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18),
        ),
      ),
    );
  }
}
