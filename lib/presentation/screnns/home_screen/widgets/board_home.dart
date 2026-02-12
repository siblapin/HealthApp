import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../data/data.dart';
import '../../../../core/constants/constants_exp.dart';
import '../../../widgets/sis_dis_puls.mosel.dart';

class BoardHomeScreen extends StatelessWidget {
  const BoardHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
          future: context.watch<DatabaseProvider>().openCardHealthBox(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              final box = context.watch<DatabaseProvider>().box;

              Color colorCard = ColorBackgroundApp().mint;
              if (box.isNotEmpty) {
                if (box.getAt(box.length - 1)?.iconStatus.toString() ==
                        'assets/icons/bad.svg' ||
                    box.getAt(box.length - 1)?.iconStatus.toString() ==
                        'assets/icons/depression.svg') {
                  colorCard = const Color.fromARGB(255, 255, 229, 227);
                }
              }
              return (box.isNotEmpty)
                  ? Card(
                      color: colorCard,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 16.0, bottom: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Text("Последнее измерение",
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16, color: ColorBackgroundApp().color_100)),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 81,
                                    child: Text(
                                      DateFormat('dd.MM.yyyy').format((box
                                              .isNotEmpty)
                                          ? box.getAt(box.length - 1)?.date ??
                                              DateTime.now()
                                          : DateTime.now()),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  SvgPicture.asset(
                                      (box.isNotEmpty)
                                          ? box
                                                  .getAt(box.length - 1)
                                                  ?.iconStatus
                                                  .toString() ??
                                              ''
                                          : '',
                                      height: 24,
                                      width: 24),
                                  const Expanded(child: SizedBox()),
                                  SvgPicture.asset(
                                      (box.isNotEmpty)
                                          ? box
                                                  .getAt(box.length - 1)
                                                  ?.iconDay
                                                  .toString() ??
                                              ''
                                          : '',
                                      height: 24,
                                      width: 24),
                                  const Expanded(child: SizedBox()),
                                  SvgPicture.asset(
                                      (box.isNotEmpty)
                                          ? box
                                                  .getAt(box.length - 1)
                                                  ?.hand
                                                  .toString() ??
                                              ''
                                          : '',
                                      height: 24,
                                      width: 24),
                                  const Expanded(child: SizedBox()),
                                  SvgPicture.asset(
                                      (box.isNotEmpty &&
                                              box
                                                      .getAt(box.length - 1)
                                                      ?.medicineText
                                                      .toString() !=
                                                  '')
                                          ? pill
                                          : '',
                                      height: 24,
                                      width: 24),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SisDisPuls(
                                    textTitle: "ВЕРХНЕЕ",
                                    inputText: (box.isNotEmpty)
                                        ? box
                                                .getAt(box.length - 1)
                                                ?.sis
                                                .toString() ??
                                            ''
                                        : '',
                                    text: 'мм рт.ст',
                                  ),
                                  SisDisPuls(
                                    textTitle: 'НИЖНЕЕ',
                                    inputText: (box.isNotEmpty)
                                        ? box
                                                .getAt(box.length - 1)
                                                ?.dis
                                                .toString() ??
                                            ''
                                        : '',
                                    text: 'мм рт.ст',
                                  ),
                                  SisDisPuls(
                                    textTitle: "ПУЛЬС",
                                    inputText: (box.isNotEmpty)
                                        ? box
                                                .getAt(box.length - 1)
                                                ?.puls
                                                .toString() ??
                                            ''
                                        : '',
                                    text: 'уд/мин',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Card(
                      color: colorCard,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 16.0, bottom: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Text("Последнее измерение",
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14, color: ColorBackgroundApp().color_100)),
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(
                              height: 35,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 81,
                                    child: Text('02.02.1988'),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SisDisPuls(
                                    textTitle: "ВЕРХНЕЕ",
                                    inputText: '110',
                                    text: 'мм рт.ст',
                                  ),
                                  SisDisPuls(
                                    textTitle: 'НИЖНЕЕ',
                                    inputText: '100',
                                    text: 'мм рт.ст',
                                  ),
                                  SisDisPuls(
                                    textTitle: "ПУЛЬС",
                                    inputText: '60',
                                    text: 'уд/мин',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            }
          }),
    );
  }
}
