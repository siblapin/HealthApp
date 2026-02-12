
import 'package:flutter/material.dart';

import '../add_results_screen/add_bottom_sheet.dart';
import 'widgets/home_screen_widgets_exp.dart';

class HomeScreenWeb extends StatelessWidget {
  final Size screenSize;
  const HomeScreenWeb({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  const SizedBox(width: 30),
                  const SizedBox(
                    width: 400,
                    child: Column(children: [
                      LogoHomeScreen(),
                      SizedBox(height: 16),
                      BoardHomeScreen(),
                      SizedBox(height: 16),
                      ButtonAddHomeScreen()
                    ]),
                  ),
                  const SizedBox(width: 70),
                  const SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        TittleListHomeScreen(),
                        ListWidgetsHomeScreen()
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (screenSize.width > 1500) ? true : false,
                    child: Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 70, right: 100),
                        child: AddBottomSheet(
                          navigarotPop: false,
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}