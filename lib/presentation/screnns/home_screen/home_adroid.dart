import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/providers/add_results_provider.dart';
import 'widgets/home_screen_widgets_exp.dart';

class HomeScreenAndroid extends StatelessWidget {
  const HomeScreenAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenList = context.select(
      (AddResultsProvider data) => data.screenList,
    );
    return Column(
                children: [
                  Visibility(
                    visible: screenList,
                    child: const Column(
                      children: [
                        LogoHomeScreen(),
                        SizedBox(height: 16),
                        BoardHomeScreen(),
                        SizedBox(height: 16),
                        ButtonAddHomeScreen(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TittleListHomeScreen(),
                  const ListWidgetsHomeScreen()
                ],
              );
  }
}