import 'package:flutter/material.dart';
import '../../core/constants/constants_exp.dart';

class AddResultsProvider extends ChangeNotifier {
  String smileyText = '';
  String dayText = '';
  String iconsHand = '';
  String iconsMedicine = pill;

  int smileyInt = 0;
  int dayInt = 0;
  int handBotton = 0;

  bool tabBotton = false;
  bool screenList = true;

  Future<void> updateDate() async {
    smileyInt = 0;
    dayInt = 0;
    handBotton = 0;
    smileyText = '';
    dayText = '';
    iconsHand = '';
    iconsMedicine = '';
    tabBotton = false;
    notifyListeners();
  }

  Future<void> smileyIntFunc(int a) async {
    switch (a) {
      case 1:
        smileyText = bad;
        break;
      case 2:
        smileyText = depression;
        break;
      case 3:
        smileyText = good;
        break;
      case 4:
        smileyText = happy;
        break;
    }
    smileyInt = a;
    notifyListeners();
  }

  Future<void> indicatorHandIcon() async {
    switch (handBotton) {
      case 2:
        iconsHand = handRight;
        break;
      case 1:
        iconsHand = handLeft;
        break;
      default:
        iconsHand = '';
    }
    notifyListeners();
  }

  Future<void> timesOfdayIntFunc(int c) async {
    switch (c) {
      case 1:
        dayText = morning;
        break;
      case 2:
        dayText = day;
        break;
      case 3:
        dayText = night;
        break;
    }

    dayInt = c;
    notifyListeners();
  }

  Future<void> handBottonFunc(int x) async {
    handBotton = x;
    notifyListeners();
  }

  Future<void> tabBottonFunc() async {
    tabBotton = !tabBotton;
    notifyListeners();
  }

  Future<void> screenListFunc() async {
    screenList = !screenList;
    notifyListeners();
  }
}
