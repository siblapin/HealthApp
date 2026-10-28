import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../../domain/providers/add_results_provider.dart';

//Блок выбора руки измерения давления

class Hand extends StatelessWidget {
  const Hand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
          width: double.infinity,
          child: Text(
            "Рука",
            textAlign: TextAlign.start,
          )),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HandBottom(
            hand: handLeft,
            nohand: nohandLeft,
            indicatorHand: 1,
          ),
          const SizedBox(width: 16),
          HandBottom(
            hand: handRight,
            nohand: nohandRight,
            indicatorHand: 2,
          ),
        ],
      )
    ]);
  }
}

class HandBottom extends StatelessWidget {
  const HandBottom({
    super.key,
    required this.hand,
    required this.nohand,
    required this.indicatorHand,
  });
  final int indicatorHand;
  final String hand;
  final String nohand;
  @override
  Widget build(BuildContext context) {
    final handBotton = context.watch<AddResultsProvider>();
    return GestureDetector(
      onTap: () {
        handBotton.handBottonFunc(indicatorHand);
        handBotton.indicatorHandIcon();
      },
      child: SizedBox(
        width: 48,
        height: 48,
        child: (handBotton.handBotton == indicatorHand)
            ? SvgPicture.asset(hand, height: 24, width: 24)
            : SvgPicture.asset(nohand, height: 24, width: 24),
      ),
    );
  }
}
