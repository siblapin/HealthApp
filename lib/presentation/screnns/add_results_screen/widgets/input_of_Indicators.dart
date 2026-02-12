//Блок ввод показателей СИС ДИД ПУЛЬС
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app_new/core/constants/constants_color.dart';


import 'package:provider/provider.dart';
import '../../../../domain/providers  /text_data_provider.dart';

class InputOfIndicators extends StatelessWidget {
  const InputOfIndicators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 16),
      width: 301,
      height: 130,
      decoration: BoxDecoration(
          color: ColorBackgroundApp().bg, borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 16, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("ВЕРХНЕЕ",
                    style: TextStyle(fontSize: 14, color: ColorBackgroundApp().textColor2)),
                Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 60,
                    child: TextData(
                      textData: context.watch<TextDataProvider>().textSisData,
                    )),
                Text("мм рт. ст.",
                    style: TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40)),
              ],
            ),
            const SizedBox(width: 32),
            Column(children: [
              Text("НИЖНЕЕ",
                  style: TextStyle(fontSize: 14, color: ColorBackgroundApp().textColor2)),
              Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 60,
                  child: TextData(
                    textData: context.watch<TextDataProvider>().textDisData,
                  )),
              Text("мм рт. ст.",
                  style: TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40)),
            ]),
            const SizedBox(width: 32),
            Column(
              children: [
                Text("ПУЛЬС",
                    style: TextStyle(fontSize: 14, color: ColorBackgroundApp().textColor2)),
                Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 60,
                    child: TextData(
                      textData: context.watch<TextDataProvider>().textPulsData,
                    )),
                Text("уд/мин", style: TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextData extends StatelessWidget {
  const TextData({super.key, required this.textData});
  final TextEditingController textData;
  @override
  Widget build(BuildContext context) {
    var textnext = FocusScope.of(context);
    return TextField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      keyboardType: TextInputType.number,
      cursorColor: ColorBackgroundApp().color_100,
      onChanged: (text) {
        if (text.length == 3) {
          textnext.nextFocus();
        }
      },
      controller: textData,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorBackgroundApp().color_40, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorBackgroundApp().color_100, width: 1.5),
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
