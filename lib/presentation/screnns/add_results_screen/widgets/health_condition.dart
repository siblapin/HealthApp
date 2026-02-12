import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../../domain/providers  /add_results_provider.dart';

//Блок выбора самочувствия "Плохо - Недомагание - Хорошо - Отлично"

class HealthCondition extends StatelessWidget {
  const HealthCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
          width: double.infinity,
          child: Text(
            "Самочувствие",
            textAlign: TextAlign.start,
          )),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
            flex: 1,
            child:
                SmBotton(iconsmiley: bad, textStatus: 'Плохо', indefecator: 1)),
        Flexible(
            flex: 2,
            child: SmBotton(
                iconsmiley: depression,
                textStatus: 'Недомагание',
                indefecator: 2)),
        Flexible(
            flex: 1,
            child: SmBotton(
                iconsmiley: good, textStatus: 'Хорошо', indefecator: 3)),
        Flexible(
            flex: 1,
            child: SmBotton(
                iconsmiley: happy, textStatus: 'Отлично', indefecator: 4)),
      ])
    ]);
  }
}

// Модель
class SmBotton extends StatelessWidget {
  const SmBotton(
      {super.key,
      required this.iconsmiley,
      required this.textStatus,
      required this.indefecator});

  final String iconsmiley;
  final String textStatus;
  final int indefecator;

  @override
  Widget build(BuildContext context) {
    final smiley = context.watch<AddResultsProvider>();
    return GestureDetector(
      onTap: () {
        smiley.smileyIntFunc(indefecator);
      },
      child: SizedBox(
        height: 50,
        child: Column(
          children: [
            const SizedBox(height: 4),
            (smiley.smileyInt == indefecator)
                ? SvgPicture.asset(
                    iconsmiley,
                    height: 26,
                    width: 26,
                  )
                : SvgPicture.asset(
                    iconsmiley,
                    height: 24,
                    width: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.color),
                  ),
            Text(textStatus,
                style: TextStyle(
                    fontSize: 12,
                    color: (smiley.smileyInt == indefecator)
                        ? ColorBackgroundApp().color_100
                        : ColorBackgroundApp().color_40))
          ],
        ),
      ),
    );
  }
}
