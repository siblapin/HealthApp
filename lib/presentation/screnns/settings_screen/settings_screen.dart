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
      backgroundColor: ColorBackgroundApp.bg,
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
                      style: TextStyle(color: ColorBackgroundApp.color_100, fontSize: 16)),
                )),
            Container(
                alignment: AlignmentDirectional.bottomStart,
                width: double.infinity,
                child: Text("Настройки",
                    style: TextStyle(color: ColorBackgroundApp.color_100, fontSize: 20))),
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
            style: TextStyle(color: ColorBackgroundApp.color_100, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _InfoChip(title: 'Верхнее', value: inputSisDis.infosisSp)),
            const SizedBox(width: 6),
            Expanded(child: _InfoChip(title: 'Нижнее', value: inputSisDis.infodisSp)),
            const SizedBox(width: 6),
            Expanded(child: _InfoChip(title: 'Пульс', value: inputSisDis.infopulsSp)),
            const SizedBox(width: 6),
            Expanded(child: _InfoChip(title: 'Возраст', value: inputSisDis.infoageSp)),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Нормы давления",
            style: TextStyle(color: ColorBackgroundApp.color_100, fontSize: 18),
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
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp.color_100)),
        onPressed: () {},
        label: Text(
          "Сохранить",
          style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 18),
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
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp.color_100)),
        onPressed: () {
          inputSisDis.imputDis();
          inputSisDis.imputSis();
          inputSisDis.impuAge();
          inputSisDis.saveData();
        },
        label: Text(
          "Обновить данные",
          style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 18),
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
              color: ColorBackgroundApp.color_100,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Text('Норма давления при вашем возрасте',
                  style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 14), softWrap: true),
              Text(inputSisDis.infoAge,
                  style: TextStyle(color: Colors.green[300], fontSize: 24)),
              Text(
                  '*показатели могут отличаться от вашего нормального давления',
                  style: TextStyle(color: ColorBackgroundApp.color_40, fontSize: 10),
                  softWrap: true),
            ],
          )),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _StatusChip(
              title: 'ВЕРХНЕЕ (SIS)',
              value: inputSisDis.infoTestSIS,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _StatusChip(
              title: 'НИЖНЕЕ (DIS)',
              value: inputSisDis.infoTestDIS,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _StatusChip(
              title: 'ПУЛЬС',
              value: inputSisDis.pulseInput.text,
              titleColor: Colors.red[300],
            ),
          ),
        ],
      ),
    ]);
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: ColorBackgroundApp.color_100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
          Text(
            value.isEmpty ? '—' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.title,
    required this.value,
    this.titleColor,
  });

  final String title;
  final String value;
  final Color? titleColor;

  Color? _valueColor(String status) {
    switch (status) {
      case 'понижено':
        return Colors.orange[300];
      case 'норма':
        return Colors.green[300];
      case 'повышено':
        return Colors.red[300];
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorBackgroundApp.color_100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: titleColor ?? _valueColor(value), fontSize: 11),
          ),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
