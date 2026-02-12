import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/constants/constants_color.dart';
import '../providers/settings_provider.dart';

class GenderBottons extends StatelessWidget {
  const GenderBottons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "Укажите ваш пол",
            style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => settingsProvider.yesNo(),
                  child: (settingsProvider.yesnoGender == true)
                      ? Container(
                          decoration: BoxDecoration(
                              color: ColorBackgroundApp().color_100,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          margin: const EdgeInsets.all(2),
                          child: Center(
                              child: Text("Мужской",
                                  style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18))))
                      : Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          margin: const EdgeInsets.all(2),
                          child: const Center(
                              child: Text("Мужской",
                                  style: TextStyle(fontSize: 18)))),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => settingsProvider.yesNo(),
                  child: (settingsProvider.yesnoGender == false)
                      ? Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: ColorBackgroundApp().color_100,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Center(
                              child: Text("Женский",
                                  style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18))))
                      : Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Center(
                              child: Text("Женский",
                                  style: TextStyle(fontSize: 18)))),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
