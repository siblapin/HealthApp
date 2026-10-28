import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/data_result_card_model.dart';

class DatabaseProvider extends ChangeNotifier {
  static const _boxName = 'cardHealth';
  late Box<DataResultCardModel> box;

  Future<void> openCardHealthBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      box = Hive.box<DataResultCardModel>(_boxName);
      return;
    }
    box = await Hive.openBox<DataResultCardModel>(_boxName);
  }

  void addCardHealthBox(DataResultCardModel dataResultCardModel) {
    box.add(dataResultCardModel);
    notifyListeners();
  }

  void delCardHealth(int index) {
    box.deleteAt(index);
    notifyListeners();
  }
}
