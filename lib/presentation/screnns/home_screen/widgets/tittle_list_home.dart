import 'package:flutter/material.dart';
import 'package:health_app_new/domain/providers/add_results_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_color.dart';

class TittleListHomeScreen extends StatelessWidget {
  const TittleListHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenList = context.select(
      (AddResultsProvider data) => data.screenList,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Ежедневные  данные',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, color: ColorBackgroundApp.textColor),
          ),
        ),
        (screenSize.width < 950)
            ? GestureDetector(
                onTap: () {
                  context.read<AddResultsProvider>().screenListFunc();
                },
                child: Text(
                  screenList ? 'Все' : 'Назад',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorBackgroundApp.color_100,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
