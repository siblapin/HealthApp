import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constants_exp.dart';
import 'widgets/status_model.dart';
import 'providers/settings_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Scaffold(
      backgroundColor: ColorBackgroundApp().bg,
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  width: double.infinity,
                  height: 50,
                  child: Text("Назад",
                      style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 16)),
                )),
            Container(
                alignment: AlignmentDirectional.bottomStart,
                width: double.infinity,
                child: Text("Настройки",
                    style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 20))),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    
              
                    StatusModel(
                      nameTitle: 'Самочувствие',
                      yesNoStatus: settingsProvider.yesNoStatus,
                      indicatorStatus: 1,
                      yesNoStatusProvider: settingsProvider.yesNoStatus,
                      icon1: bad,
                      icon2: depression,
                      icon3: good,
                      icon4: happy,
                    ),
                    const SizedBox(height: 10),
                    StatusModel(
                      nameTitle: 'Время суток',
                      yesNoStatus: settingsProvider.yesNoDay,
                      indicatorStatus: 2,
                      yesNoStatusProvider: settingsProvider.yesNoDay,
                      icon1: morning,
                      icon2: day,
                      icon3: night,
                      icon4: '',
                    ),
                    const SizedBox(height: 10),
                    StatusModel(
                      nameTitle: 'Рука для измерения',
                      yesNoStatus: settingsProvider.yesNoHand,
                      indicatorStatus: 3,
                      yesNoStatusProvider: settingsProvider.yesNoHand,
                      icon1: handLeft,
                      icon2: handRight,
                      icon3: '',
                      icon4: '',
                    ),
                    const SizedBox(height: 20),
                    // const ButtonSave(),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class OutputSisDisPuls extends StatelessWidget {
  const OutputSisDisPuls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var inputSisDis = context.watch<SettingsProvider>();

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            "ИНФОРМАЦИЯ",
            style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorBackgroundApp().color_100,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text('Верхнее'),
                  Text(inputSisDis.infosisSp,
                      style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 24))
                ],
              )),
          const SizedBox(height: 5),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorBackgroundApp().color_100,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text('Нижнее'),
                  Text(inputSisDis.infodisSp,
                      style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 24))
                ],
              )),
          const SizedBox(height: 5),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorBackgroundApp().color_100,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text('Пульс'),
                  Text(inputSisDis.infopulsSp,
                      style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 24))
                ],
              )),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorBackgroundApp().color_100,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text('Возраст'),
                  Text(inputSisDis.infoageSp,
                      style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 24))
                ],
              )),
        ]),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Нормы давления",
            style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ButtonSave extends StatelessWidget {
  const ButtonSave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp().color_100)),
        onPressed: () {},
        label: Text(
          "Сохранить",
          style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18),
        ),
      ),
    );
  }
}

class ButtonUpdateResult extends StatelessWidget {
  const ButtonUpdateResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var inputSisDis = context.read<SettingsProvider>();
    return SizedBox(
   
      height: 70,
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp().color_100)),
        onPressed: () {
          inputSisDis.updateSisDisPuls();
          (inputSisDis.disInput.text.isNotEmpty) ? inputSisDis.imputDis() : 0;
          (inputSisDis.sisInput.text.isNotEmpty) ? inputSisDis.imputSis() : 0;
          (inputSisDis.ageInput.text.isNotEmpty) ? inputSisDis.impuAge() : 0;
          inputSisDis.saveData();
        },
        label: Text(
          "Обновить данные",
          style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18),
        ),
      ),
    );
  }
}

class InfoWidgetsInput extends StatelessWidget {
  const InfoWidgetsInput({super.key});

  @override
  Widget build(BuildContext context) {
    var inputSisDis = context.watch<SettingsProvider>();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ColorBackgroundApp().color_100,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text('Норма давления при вашем возрасте',
                  style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 14), softWrap: true),
              Text(inputSisDis.infoAge,
                  style: TextStyle(color: Colors.green[300], fontSize: 24)),
              Text(
                  '*показатели могут отличаться от вашего нормального давления',
                  style: TextStyle(color: ColorBackgroundApp().color_40, fontSize: 10),
                  softWrap: true),
            ],
          )),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorBackgroundApp().color_100,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Text('ВЕРХНЕЕ (SIS)',
                    softWrap: true,
                    style: TextStyle(
                        color: (inputSisDis.infoTestSIS == 'понижено')
                            ? Colors.orange[300]
                            : (inputSisDis.infoTestSIS == 'норма')
                                ? Colors.green[300]
                                : (inputSisDis.infoTestSIS == 'повышено')
                                    ? Colors.red[300]
                                    : Colors.white)),
                Text(inputSisDis.infoTestSIS,
                    style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 14))
              ],
            )),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorBackgroundApp().color_100,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Text('НИЖНЕЕ (DIS)',
                    softWrap: true,
                    style: TextStyle(
                        color: (inputSisDis.infoTestDIS == 'понижено')
                            ? Colors.orange[300]
                            : (inputSisDis.infoTestDIS == 'норма')
                                ? Colors.green[300]
                                : (inputSisDis.infoTestDIS == 'повышено')
                                    ? Colors.red[300]
                                    : Colors.white)),
                Text(inputSisDis.infoTestDIS,
                    style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 14))
              ],
            )),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorBackgroundApp().color_100,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Text('ПУЛЬС', style: TextStyle(color: Colors.red[300])),
                Text(inputSisDis.pulseInput.text,
                    style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 14))
              ],
            )),
      ]),
    ]);
  }
}
