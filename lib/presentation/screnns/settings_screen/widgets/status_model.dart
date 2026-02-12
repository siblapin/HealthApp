import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import '../../../../core/constants/constants_color.dart';
import '../providers/settings_provider.dart';

class StatusModel extends StatelessWidget {
  const StatusModel({
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
    required this.nameTitle,
    required this.yesNoStatus,
    required this.indicatorStatus,
    required this.yesNoStatusProvider,
    super.key,
  });
  final String icon1;
  final String icon2;
  final String icon3;
  final String icon4;
  final String nameTitle;
  final bool yesNoStatus;
  final bool yesNoStatusProvider;
  final int indicatorStatus;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            nameTitle,
            style: TextStyle(color: ColorBackgroundApp().color_100, fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          icon1,
                          height: 26,
                          width: 26,
                        ),
                        SvgPicture.asset(
                          icon2,
                          height: 26,
                          width: 26,
                        ),
                        SvgPicture.asset(
                          icon3,
                          height: 26,
                          width: 26,
                        ),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => settingsProvider.yesNoStatusF(
                        yesNoStatus, indicatorStatus),
                    child: (yesNoStatusProvider == true)
                        ? Container(
                            decoration: BoxDecoration(
                                color: ColorBackgroundApp().color_100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            margin: const EdgeInsets.all(2),
                            child: Center(
                                child: Text("вкл",
                                    style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18))))
                        : Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            margin: const EdgeInsets.all(2),
                            child: const Center(
                                child: Text("вкл",
                                    style: TextStyle(fontSize: 18)))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () => settingsProvider.yesNoStatusF(
                        yesNoStatus, indicatorStatus),
                    child: (yesNoStatusProvider == false)
                        ? Container(
                            decoration: BoxDecoration(
                                color: ColorBackgroundApp().color_100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            margin: const EdgeInsets.all(2),
                            child: Center(
                                child: Text("выкл",
                                    style: TextStyle(color: ColorBackgroundApp().bg, fontSize: 18))))
                        : Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            margin: const EdgeInsets.all(2),
                            child: const Center(
                                child: Text("выкл",
                                    style: TextStyle(fontSize: 18)))),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
