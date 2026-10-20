import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/constants_exp.dart';
class NavigationProvider extends ChangeNotifier {
 int currenBotton1Index = 0;
  int currenBotton2Index = 0;
 void navigationBar (int index) {
       
      currenBotton1Index = index;
       currenBotton2Index = index;
        notifyListeners(); 
            

        }
}


class AddResultsProvider extends ChangeNotifier {
  String smileyText = '';
  String dayText = '';
  String iconsHand = '';
  String iconsMedicine = pill;

  int smileyInt = 0; // индикатор иконок смайликов самочувствия
  int dayInt = 0; // индикатор иконок время суток
  int handBotton = 0; // переменная кнопки активировать руку измерения пульса

  bool tabBotton = false; // переменная кнопки добавить лекарства
  bool screenList = true; // переменная скрыть/раскрыть лист

// сбрасыввет выбраные настроки в "add_resuls_screen"
  Future<void> updateDate() async {
    smileyInt = 0;
    dayInt = 0;
    handBotton = 0;
    smileyText = '';
    dayText = '';
    iconsHand = '';
    iconsMedicine = '';
    notifyListeners();
  }

// функция иконок смайликов самочувствия
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

  // функция иконок смайликов самочувствия
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

// функция иконок время суток
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

  // функция выбора руки
  Future<void> handBottonFunc(int x) async {
    handBotton = x;
    notifyListeners();
  }

// функция кнопки добавить лекарства
  Future<void> tabBottonFunc() async {
    if (tabBotton == true) {
      tabBotton = false;
    } else {
      tabBotton = true;
    }
    notifyListeners();
  }

// функция скрыть/раскрыть лист
  Future<void> screenListFunc() async {
    if (screenList == true) {
      screenList = false;
    } else {
      screenList = true;
    }
    notifyListeners();
  }
}
