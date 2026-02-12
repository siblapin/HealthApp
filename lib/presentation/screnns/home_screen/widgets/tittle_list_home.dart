import 'package:flutter/material.dart';
import 'package:health_app_new/domain/providers%20%20/add_results_provider.dart';

import 'package:provider/provider.dart';
import '../../../../core/constants/constants_color.dart';

class TittleListHomeScreen extends StatelessWidget {
  const TittleListHomeScreen({
    super.key,
  });
  final String text1 = "Все";
  final String text2 = "Назад";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final screenList = context.watch<AddResultsProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Ежедневные  данные",
            style: TextStyle(fontSize: 18, color: ColorBackgroundApp().textColor)),
        (screenSize.width < 950)
            ? GestureDetector(
                onTap: () {
                  screenList.screenListFunc();
                },
                child: Text((screenList.screenList == true) ? text1 : text2,
                    style: TextStyle(fontSize: 14, color: ColorBackgroundApp().color_100)),
              )
            : const SizedBox(),
      ],
    );
  }
}
