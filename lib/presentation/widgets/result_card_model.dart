import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/constants/constants_exp.dart';
import '../../data/data.dart';
import 'safe_svg.dart';
import 'sis_dis_puls.dart';

//Виджет модели КАРТОЧКИ
class ResultCardModel extends StatefulWidget {
  const ResultCardModel({
    super.key,
    required this.sis,
    required this.smail,
    required this.iconDay,
    required this.dis,
    required this.puls,
    required this.medicineText,
    required this.date,
    required this.index,
    required this.hand,
  });

  final String smail; // Иконка самочувствия
  final String iconDay; // Иконка время суток
  final String sis; // СИС показатель из TextField
  final String dis; // Дис показатель из TextField
  final String puls; // Пульс показатель из TextField
  final String medicineText;

  final String date;
  final String hand; // Иконка руки
  final int index;

  @override
  State<ResultCardModel> createState() => _ResultCardModelState();
}

class _ResultCardModelState extends State<ResultCardModel> {
  bool onOff = false;

  @override
  Widget build(BuildContext context) {
    final deletCard = context.read<DatabaseProvider>();

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: ColorBackgroundApp.colorWhite),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: widget.smail == bad || widget.smail == depression
                          ? const Color.fromARGB(255, 255, 229, 227)
                          : ColorBackgroundApp.mint,
                    ),
                    child: Text(
                      widget.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SafeSvg(asset: widget.smail, height: 20, width: 20),
                const SizedBox(width: 6),
                SafeSvg(asset: widget.iconDay, height: 20, width: 20),
                const SizedBox(width: 6),
                SafeSvg(asset: widget.hand, height: 20, width: 20),
                const SizedBox(width: 6),
                SafeSvg(
                  asset: widget.medicineText.isNotEmpty ? pill : '',
                  height: 20,
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      onOff = !onOff;
                    });
                  },
                  child: Icon(
                    onOff
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: SisDisPuls(
                      textTitle: 'ВЕРХНЕЕ',
                      inputText: widget.sis,
                      text: 'мм рт.ст',
                    ),
                  ),
                  Expanded(
                    child: SisDisPuls(
                      textTitle: 'НИЖНЕЕ',
                      inputText: widget.dis,
                      text: 'мм рт.ст',
                    ),
                  ),
                  Expanded(
                    child: SisDisPuls(
                      textTitle: 'ПУЛЬС',
                      inputText: widget.puls,
                      text: 'у/мин',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Visibility(
                visible: onOff,
                child: Column(
                  children: [
                    const Divider(),
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Лекарства",
                          style: TextStyle(fontSize: 16, color: ColorBackgroundApp.color_100),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(pill, height: 20, width: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.medicineText.isNotEmpty
                                ? widget.medicineText
                                : 'не указано',
                            overflow: TextOverflow.ellipsis,
                            style: widget.medicineText.isEmpty
                                ? TextStyle(
                                    fontSize: 12,
                                    color: ColorBackgroundApp.color_40,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
// рука для измерения пульса
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Рука",
                          style: TextStyle(fontSize: 16, color: ColorBackgroundApp.color_100),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SafeSvg(asset: widget.hand),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.hand == handLeft
                                ? 'Левая'
                                : widget.hand == handRight
                                    ? 'Правая'
                                    : 'Рука для измерения не выбрана',
                            overflow: TextOverflow.ellipsis,
                            style: widget.hand == handLeft ||
                                    widget.hand == handRight
                                ? null
                                : TextStyle(
                                    fontSize: 12,
                                    color: ColorBackgroundApp.color_40,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    //конец

                    Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      deletCard.delCardHealth(widget.index);
                                    },
                                    child: SvgPicture.asset(basket,
                                        height: 24, width: 24)),
                                Visibility(
                                  visible: false,
                                  child: SvgPicture.asset(editing,
                                      height: 24, width: 24),
                                ),
                              ],
                            )))
                  ],
                ))
          ],
        ));
  }
}
