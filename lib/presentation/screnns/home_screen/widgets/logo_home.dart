import 'package:flutter/material.dart';

import '../../../../core/constants/constants_color.dart';
import '../../settings_screen/settings_screen.dart';

class LogoHomeScreen extends StatelessWidget {
  const LogoHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 31,
      child: Row(
        children: [
          const SizedBox(width: 24),
          Expanded(
            child: SizedBox(
              child: Center(
                child: Text(
                  "Дневник давления",
                  style: TextStyle(
                    color: ColorBackgroundApp().color_100,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingScreen()));
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: Icon(Icons.settings, color: ColorBackgroundApp().color_100),
              ),
            ),
          )
        ],
      ),
    );
  }
}
