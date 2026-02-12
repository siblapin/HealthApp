import 'package:flutter/material.dart';

class BoardHomeProvider extends ChangeNotifier {
  String smileyTextBoard = '';
  String dayTextBoard = '';
  String iconsHand = '';

  Future<void> boardHomeFunc() async {
    notifyListeners();
  }
}
