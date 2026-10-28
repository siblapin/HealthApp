import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/constants_exp.dart';
import '../../domain/providers/navigation_provider.dart';

class NavigationModel extends StatelessWidget {
  const NavigationModel({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select(
      (NavigationProvider nav) => nav.selectedIndex,
    );
    final nav = context.read<NavigationProvider>();
    return NavigationBar(
      onDestinationSelected: nav.navigationBar,
      indicatorColor: ColorBackgroundApp.color_100,
      selectedIndex: selectedIndex,
      backgroundColor: ColorBackgroundApp.bg,
      destinations: const [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: Colors.white),
          icon: Icon(Icons.home_outlined),
          label: 'Главная',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.local_hospital, color: Colors.white),
          icon: Icon(Icons.local_hospital),
          label: 'Полезное',
        ),
      ],
    );
  }
}
