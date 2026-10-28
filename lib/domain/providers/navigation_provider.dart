import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void navigationBar(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    notifyListeners();
  }
}
