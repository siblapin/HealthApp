import 'package:flutter/material.dart';
import 'package:health_app_new/presentation/screnns/settings_screen/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constants_color.dart';
import '../../../../data/data.dart';
import '../../../data/models/data_result_card_model.dart';
import '../../../domain/providers  /add_results_provider.dart';
import '../../../domain/providers  /text_data_provider.dart';

import 'widgets/add_results_widgets_exp.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key, required this.navigarotPop});
  final bool navigarotPop;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
      
            color: Colors.white,
      
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Text("Новое измерение",
                    style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 20)),
              ),
              const InputOfIndicators(),
              Expanded(
                child: ListView(
                  children: [
                    Visibility(
                        visible: settingsProvider.yesNoStatus,
                        child: const HealthCondition()),
                    Visibility(
                        visible: settingsProvider.yesNoDay,
                        child: const TimesOfDay()),
                    Visibility(
                        visible: settingsProvider.yesNoHand,
                        child: const Hand()),
                    const Medicine(),
                    ButtonAddResult(
                      navigarotPop: navigarotPop,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonAddResult extends StatelessWidget {
  const ButtonAddResult({super.key, required this.navigarotPop});
  final bool navigarotPop;

  @override
  Widget build(BuildContext context) {
    final data = context.read<AddResultsProvider>();
    final dataTextProvider = context.read<TextDataProvider>();
    final databaseProvider = context.read<DatabaseProvider>();

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp().color_100)),
        onPressed: () {
          databaseProvider.addCardHealthBox(DataResultCardModel(
            sis: dataTextProvider.textSisData.text,
            dis: dataTextProvider.textDisData.text,
            puls: dataTextProvider.textPulsData.text,
            iconStatus: data.smileyText,
            iconDay: data.dayText,
            medicineText: dataTextProvider.textDataMedicine.text,
            date: DateTime.now(),
            hand: data.iconsHand,
          ));

          dataTextProvider.textDisData.clear();
          dataTextProvider.textSisData.clear();
          dataTextProvider.textPulsData.clear();
          dataTextProvider.textDataMedicine.clear();
          // обновление
          data.updateDate();
          data.tabBotton = false;

          // вернуться назад

          (navigarotPop == true) ? Navigator.pop(context) : null;
        },
        icon: Icon(Icons.add_circle, color: ColorBackgroundApp().bg),
        label: Text(
          "Сохранить",
          style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18),
        ),
      ),
    );
  }
}
