import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/constants_color.dart';
import '../providers/settings_provider.dart';

class InputOfIndicatorsSettings extends StatelessWidget {
  const InputOfIndicatorsSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var inputSisDis = context.read<SettingsProvider>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: ColorBackgroundApp().color_100,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InputModel(
                    nameInput: 'Верхнее',
                    counterInput: InputCounterModel(
                      inputSisDis: inputSisDis.sisInput,
                      quantity: 3,
                    ),
                    nameText: 'мм рт. ст'),
                InputModel(
                    nameInput: 'Нижнее',
                    counterInput: InputCounterModel(
                      inputSisDis: inputSisDis.disInput,
                      quantity: 3,
                    ),
                    nameText: 'мм рт. ст'),
                InputModel(
                    nameInput: 'Пульс',
                    counterInput: InputCounterModel(
                      inputSisDis: inputSisDis.pulseInput,
                      quantity: 3,
                    ),
                    nameText: 'уд/мин'),
                InputModel(
                    nameInput: 'Возраст',
                    counterInput: InputCounterModel(
                      inputSisDis: inputSisDis.ageInput,
                      quantity: 2,
                    ),
                    nameText: 'полных лет'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputModel extends StatelessWidget {
  final String nameInput;
  final String nameText;
  final Widget counterInput;

  const InputModel({
    required this.nameInput,
    required this.counterInput,
    required this.nameText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nameInput,
          style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 16),
        ),
        counterInput,
        Text(nameText, style: TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40)),
      ],
    );
  }
}

class InputCounterModel extends StatelessWidget {
  const InputCounterModel(
      {super.key, required this.inputSisDis, required this.quantity});
  final TextEditingController inputSisDis;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    var textnext = FocusScope.of(context);
    return SizedBox(
      width: 70,
      child: TextField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(quantity),
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
        keyboardType: TextInputType.number,
        cursorColor: ColorBackgroundApp().color_100,
        onChanged: (text) {
          if (text.length == 3) {
            textnext.nextFocus();
          }
        },
        controller: inputSisDis,
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
      ),
    );
  }
}
