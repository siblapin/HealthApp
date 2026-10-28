import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../../domain/providers/add_results_provider.dart';

class HealthCondition extends StatelessWidget {
  const HealthCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text('Самочувствие', textAlign: TextAlign.start),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SmBotton(
                iconsmiley: bad,
                textStatus: 'Плохо',
                indefecator: 1,
              ),
            ),
            Expanded(
              child: SmBotton(
                iconsmiley: depression,
                textStatus: 'Недомагание',
                indefecator: 2,
              ),
            ),
            Expanded(
              child: SmBotton(
                iconsmiley: good,
                textStatus: 'Хорошо',
                indefecator: 3,
              ),
            ),
            Expanded(
              child: SmBotton(
                iconsmiley: happy,
                textStatus: 'Отлично',
                indefecator: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SmBotton extends StatelessWidget {
  const SmBotton({
    super.key,
    required this.iconsmiley,
    required this.textStatus,
    required this.indefecator,
  });

  final String iconsmiley;
  final String textStatus;
  final int indefecator;

  @override
  Widget build(BuildContext context) {
    final smiley = context.watch<AddResultsProvider>();
    final selected = smiley.smileyInt == indefecator;
    return GestureDetector(
      onTap: () {
        smiley.smileyIntFunc(indefecator);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconsmiley,
            height: selected ? 26 : 24,
            width: selected ? 26 : 24,
            colorFilter: selected
                ? null
                : const ColorFilter.mode(Colors.white, BlendMode.color),
          ),
          const SizedBox(height: 2),
          Text(
            textStatus,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: selected
                  ? ColorBackgroundApp.color_100
                  : ColorBackgroundApp.color_40,
            ),
          ),
        ],
      ),
    );
  }
}
