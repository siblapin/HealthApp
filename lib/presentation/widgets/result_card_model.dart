import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/constants/constants_exp.dart';
import '../../data/data.dart';
import 'sis_dis_puls.mosel.dart';

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
            color: ColorBackgroundApp().colorWhite),
        child: Column(
          children: [
            SizedBox(
              height: 28,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 2, left: 4, right: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        color: widget.smail == bad
                            ? const Color.fromARGB(255, 255, 229, 227)
                            : widget.smail == depression
                                ? const Color.fromARGB(255, 255, 229, 227)
                                : ColorBackgroundApp().mint,
                      ),
                      child: Text(widget.date)),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(widget.smail, height: 24, width: 24),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(widget.iconDay, height: 24, width: 24),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(widget.hand, height: 24, width: 24),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset((widget.medicineText.isNotEmpty) ? pill : '',
                      height: 24, width: 24),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (onOff == false) ? onOff = true : onOff = false;
                      });
                    },
                    child: (onOff)
                        ? const SizedBox(
                            width: 34,
                            height: 34,
                            child: Icon(Icons.keyboard_arrow_up),
                          )
                        : const SizedBox(
                            width: 34,
                            height: 34,
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                  )
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SisDisPuls(
                    textTitle: "ВЕРХНЕЕ",
                    inputText: widget.sis.toString(),
                    text: 'мм рт.ст',
                  ),
                  SisDisPuls(
                    textTitle: "НИЖНЕЕ",
                    inputText: widget.dis.toString(),
                    text: 'мм рт.ст',
                  ),
                  SisDisPuls(
                    textTitle: "ПУЛЬС",
                    inputText: widget.puls.toString(),
                    text: 'у/мин',
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
                          style: TextStyle(fontSize: 16, color: ColorBackgroundApp().color_100),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(height: 10),
                    Row(children: [
                      SvgPicture.asset(pill, height: 20, width: 20),
                      const SizedBox(width: 10),
                      SizedBox(
                          height: 20,
                          child: (widget.medicineText.isNotEmpty)
                              ? Text(widget.medicineText,
                                  overflow: TextOverflow.ellipsis)
                              : Text(
                                  'не указано',
                                  style:
                                      TextStyle(fontSize: 12, color: ColorBackgroundApp().color_40),
                                ))
                    ]),
// рука для измерения пульса
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Рука",
                          style: TextStyle(fontSize: 16, color: ColorBackgroundApp().color_100),
                          textAlign: TextAlign.left,
                        )),
                    const SizedBox(height: 10),
                    Row(children: [
                      SizedBox(
                          child: SvgPicture.asset(widget.hand,
                              height: 24, width: 24)),
                      const SizedBox(width: 10),
                      (widget.hand == handLeft)
                          ? const SizedBox(child: Text("Левая"))
                          : (widget.hand == handRight)
                              ? const SizedBox(child: Text("Правая"))
                              : SizedBox(
                                  child: Text("Рука для измерения не выбрана",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12, color: ColorBackgroundApp().color_40)))
                    ]),
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
