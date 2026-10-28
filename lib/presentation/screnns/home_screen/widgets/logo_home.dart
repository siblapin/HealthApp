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
      width: double.infinity,
      height: 32,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Дневник давления',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorBackgroundApp.color_100,
                fontSize: 22,
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
                child: Icon(Icons.settings, color: ColorBackgroundApp.color_100),
              ),
            ),
          )
        ],
      ),
    );
  }
}
