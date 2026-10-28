import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../data/data.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../widgets/safe_svg.dart';
import '../../../widgets/sis_dis_puls.dart';

class BoardHomeScreen extends StatelessWidget {
  const BoardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = context.watch<DatabaseProvider>().box;
    if (box.isEmpty) {
      return Card(
        color: ColorBackgroundApp.mint,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16.0,
            bottom: 16,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Пока нет измерений',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: ColorBackgroundApp.color_100),
            ),
          ),
        ),
      );
    }

    final last = box.getAt(box.length - 1);
    if (last == null) return const SizedBox.shrink();

    final isBadMood =
        last.iconStatus == 'assets/icons/bad.svg' ||
        last.iconStatus == 'assets/icons/depression.svg';
    final colorCard = isBadMood
        ? const Color.fromARGB(255, 255, 229, 227)
        : ColorBackgroundApp.mint;

    return Card(
      color: colorCard,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16.0,
          bottom: 16,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              width: double.infinity,
              child: Text(
                'Последнее измерение',
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorBackgroundApp.color_100,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  SizedBox(
                    width: 81,
                    child: Text(DateFormat('dd.MM.yyyy').format(last.date)),
                  ),
                  const Expanded(child: SizedBox()),
                  SafeSvg(asset: last.iconStatus),
                  const Expanded(child: SizedBox()),
                  SafeSvg(asset: last.iconDay),
                  const Expanded(child: SizedBox()),
                  SafeSvg(asset: last.hand),
                  const Expanded(child: SizedBox()),
                  SafeSvg(asset: last.medicineText.isNotEmpty ? pill : ''),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: SisDisPuls(
                    textTitle: 'ВЕРХНЕЕ',
                    inputText: last.sis,
                    text: 'мм рт.ст',
                  ),
                ),
                Expanded(
                  child: SisDisPuls(
                    textTitle: 'НИЖНЕЕ',
                    inputText: last.dis,
                    text: 'мм рт.ст',
                  ),
                ),
                Expanded(
                  child: SisDisPuls(
                    textTitle: 'ПУЛЬС',
                    inputText: last.puls,
                    text: 'уд/мин',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
