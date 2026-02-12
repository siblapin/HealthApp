//Блок время суток
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../../domain/providers  /add_results_provider.dart';

class TimesOfDay extends StatelessWidget {
  const TimesOfDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
          width: double.infinity,
          child: Text(
            "Время",
            textAlign: TextAlign.start,
          )),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DayBotton(icon: morning, textStatus: 'Утро', indefecatorDay: 1),
          DayBotton(icon: day, textStatus: 'День', indefecatorDay: 2),
          DayBotton(icon: night, textStatus: 'Вечер', indefecatorDay: 3),
        ],
      ),
      const SizedBox(height: 12),
    ]);
  }
}

class DayBotton extends StatelessWidget {
  const DayBotton({
    super.key,
    required this.icon,
    required this.textStatus,
    required this.indefecatorDay,
  });

  final String icon;
  final String textStatus;
  final int indefecatorDay;

  @override
  Widget build(BuildContext context) {
    final day = context.watch<AddResultsProvider>();
    return GestureDetector(
      onTap: () {
        day.timesOfdayIntFunc(indefecatorDay);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 15, top: 4, bottom: 4),
        decoration: BoxDecoration(
            color: (day.dayInt == indefecatorDay) ? ColorBackgroundApp().color_100 : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: ColorBackgroundApp().color_100)),
        child: Row(
          children: [
            SvgPicture.asset(icon,

                // ignore: deprecated_member_use
                color: (day.dayInt == indefecatorDay) ? Colors.white : null,
                height: 24,
                width: 24),
            const SizedBox(width: 12),
            Text(textStatus,
                style: TextStyle(
                    color: (day.dayInt == indefecatorDay)
                        ? Colors.white
                        : ColorBackgroundApp().color_100,
                    fontSize: 12))
          ],
        ),
      ),
    );
  }
}
