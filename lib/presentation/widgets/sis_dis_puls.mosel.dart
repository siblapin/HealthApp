//MODEL: показатели СИС ДИД и Пульс
import 'package:flutter/material.dart';
import '../../core/constants/constants_color.dart';



class SisDisPuls extends StatelessWidget {
  const SisDisPuls({
    super.key,
    required this.textTitle,
    required this.text,
    required this.inputText,
  });
  final String textTitle; // ДИС - СИС - ПУЛЬС
  final String text; // мм.рт.ст
  final String inputText; // показатели

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(textTitle,
              softWrap: true,
              style: TextStyle(fontSize: 14, color: ColorBackgroundApp().textColor2),
              overflow: TextOverflow.ellipsis),
          Text(inputText,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 22, color: ColorBackgroundApp().textColor)),
          Text(text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40)),
        ],
      ),
    );
  }
}
