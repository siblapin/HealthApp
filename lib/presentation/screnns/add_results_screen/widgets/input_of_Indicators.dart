import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app_new/core/constants/constants_color.dart';
import 'package:provider/provider.dart';
import '../../../../domain/providers/text_data_provider.dart';

class InputOfIndicators extends StatelessWidget {
  const InputOfIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    final textData = context.read<TextDataProvider>();
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorBackgroundApp.bg,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: _PressureColumn(
                title: 'ВЕРХНЕЕ',
                unit: 'мм рт. ст.',
                controller: textData.textSisData,
              ),
            ),
            Expanded(
              child: _PressureColumn(
                title: 'НИЖНЕЕ',
                unit: 'мм рт. ст.',
                controller: textData.textDisData,
              ),
            ),
            Expanded(
              child: _PressureColumn(
                title: 'ПУЛЬС',
                unit: 'уд/мин',
                controller: textData.textPulsData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PressureColumn extends StatelessWidget {
  const _PressureColumn({
    required this.title,
    required this.unit,
    required this.controller,
  });

  final String title;
  final String unit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13, color: ColorBackgroundApp.textColor2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: TextData(textData: controller),
        ),
        Text(
          unit,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11, color: ColorBackgroundApp.color_40),
        ),
      ],
    );
  }
}

class TextData extends StatelessWidget {
  const TextData({super.key, required this.textData});
  final TextEditingController textData;
  @override
  Widget build(BuildContext context) {
    final textNext = FocusScope.of(context);
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      keyboardType: TextInputType.number,
      cursorColor: ColorBackgroundApp.color_100,
      onChanged: (text) {
        if (text.length == 3) {
          textNext.nextFocus();
        }
      },
      controller: textData,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorBackgroundApp.color_40, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorBackgroundApp.color_100,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
