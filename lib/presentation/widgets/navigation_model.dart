import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/constants_exp.dart';
import '../../domain/providers  /add_results_provider.dart';

class NavigationModel extends StatelessWidget {
   const NavigationModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     NavigationProvider helpData = context.watch<NavigationProvider>();
    return AnimatedBuilder(
      animation: helpData, builder: (BuildContext context, Widget? child) {return NavigationBar(
          onDestinationSelected:(int inde){
              helpData.navigationBar(inde);
          },
              indicatorColor: ColorBackgroundApp().color_100,
              selectedIndex: helpData.currenBotton1Index,
        backgroundColor: ColorBackgroundApp().bg,
        destinations: [
                NavigationDestination(
      selectedIcon: Icon(Icons.home, color: Colors.white,),
      icon: Icon(Icons.home_outlined),
      label: 'Главная',
                ),
                NavigationDestination(
      selectedIcon: Icon(Icons.local_hospital, color: Colors.white,),
      icon: Icon(Icons.local_hospital),
      label: 'Полезное',
                )
              ]); },
      
    );
  }
}