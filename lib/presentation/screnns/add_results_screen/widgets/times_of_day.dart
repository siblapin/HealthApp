import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../../domain/providers/add_results_provider.dart';

class TimesOfDay extends StatelessWidget {
  const TimesOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text('Время', textAlign: TextAlign.start),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DayBotton(
                icon: morning,
                textStatus: 'Утро',
                indefecatorDay: 1,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DayBotton(
                icon: day,
                textStatus: 'День',
                indefecatorDay: 2,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DayBotton(
                icon: night,
                textStatus: 'Вечер',
                indefecatorDay: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
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
    final selected = day.dayInt == indefecatorDay;
    return GestureDetector(
      onTap: () {
        day.timesOfdayIntFunc(indefecatorDay);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? ColorBackgroundApp.color_100 : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: ColorBackgroundApp.color_100),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: selected
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                textStatus,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : ColorBackgroundApp.color_100,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
