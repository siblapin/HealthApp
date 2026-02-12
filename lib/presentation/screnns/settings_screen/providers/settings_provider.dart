import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider extends ChangeNotifier {
  bool yesnoGender = true;
  bool yesNoStatus = true;
  bool yesNoDay = true;
  bool yesNoHand = true;
  SettingsProvider() {
    getPrefsSettings();
  }

  String infoTestSIS = '';
  String infoTestDIS = '';
  String infoAge = '';

  String infosisSp = '';
  String infodisSp = '';
  String infopulsSp = '';
  String infoageSp = '';

  //показатели указанные пользователем
  TextEditingController sisInput = TextEditingController();
  TextEditingController disInput = TextEditingController();
  TextEditingController pulseInput = TextEditingController();
  TextEditingController ageInput = TextEditingController();

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    infosisSp = sisInput.text;
    infodisSp = disInput.text;
    infopulsSp = pulseInput.text;
    infoageSp = ageInput.text;
    notifyListeners();
    // Сохранение данных
    await prefs.setString('infoSIS', infosisSp);
    await prefs.setString('infoDIS', infodisSp);
    await prefs.setString('infoPulse', infopulsSp);
    await prefs.setString('infoAge', infoageSp);
  }

  Future<void> updateSisDisPuls() async {
    notifyListeners();
  }

  Future<void> yesNo() async {
    final prefs = await SharedPreferences.getInstance();

    if (yesnoGender == true) {
      yesnoGender = false;
      notifyListeners();
      prefs.setBool('yesnoGender', yesnoGender);
    } else {
      yesnoGender = true;
      notifyListeners();
      prefs.setBool('yesnoGender', yesnoGender);
    }
  }

  Future<void> yesNoStatusF(bool a, int b) async {
    final prefs = await SharedPreferences.getInstance();
    switch (b) {
      case 1:
        if (yesNoStatus == true) {
          yesNoStatus = false;
          notifyListeners();
          prefs.setBool('yesNoStatus', yesNoStatus);
        } else {
          yesNoStatus = true;
          notifyListeners();
          prefs.setBool('yesNoStatus', yesNoStatus);
        }
        break;
      case 2:
        if (yesNoDay == true) {
          yesNoDay = false;
          notifyListeners();
          prefs.setBool('yesNoDay', yesNoDay);
        } else {
          yesNoDay = true;
          notifyListeners();
          prefs.setBool('yesNoDay', yesNoDay);
        }
        break;
      case 3:
        if (yesNoHand == true) {
          yesNoHand = false;
          notifyListeners();
          prefs.setBool('yesNoHand', yesNoHand);
        } else {
          yesNoHand = true;
          notifyListeners();
          prefs.setBool('yesNoHand', yesNoHand);
        }
        break;
    }

    notifyListeners();
  }

  Future<void> getPrefsSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('yesnoGender')) {
      yesnoGender = prefs.getBool("yesnoGender")!;
      notifyListeners();
    }
    if (prefs.containsKey('yesNoStatus')) {
      yesNoStatus = prefs.getBool("yesNoStatus")!;
      notifyListeners();
    }
    if (prefs.containsKey('yesNoDay')) {
      yesNoDay = prefs.getBool("yesNoDay")!;
      notifyListeners();
    }
    if (prefs.containsKey('yesNoHand')) {
      yesNoHand = prefs.getBool("yesNoHand")!;
      notifyListeners();
    }
    if (prefs.containsKey('infoSIS')) {
      infosisSp = prefs.getString("infoSIS")!;
      notifyListeners();
    }
    if (prefs.containsKey('infoDIS')) {
      infodisSp = prefs.getString("infoDIS")!;
      notifyListeners();
    }
    if (prefs.containsKey('infoPulse')) {
      infopulsSp = prefs.getString("infoPulse")!;
      notifyListeners();
    }
    if (prefs.containsKey('infoAge')) {
      infoageSp = prefs.getString("infoAge")!;
      notifyListeners();
    }
  }

//ВЕРХНЕЕ
  void imputSis() {
    int? age = int.tryParse(ageInput.text);
    int? sis = int.tryParse(sisInput.text);
    String sisText1 = "понижено";
    String sisText2 = "норма";
    String sisText3 = "повышено";
    if (age! <= 19) {
      //Ваше нормльное давление

      if (sis! <= 105) {
        //14-19
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 105 && sis < 120) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 120) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 20 && age <= 24) {
      //20-24
      //Ваше нормльное давление

      if (sis! <= 108) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 108 && sis < 132) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 132) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 25 && age <= 29) {
      //25-29
      //Ваше нормльное давление

      if (sis! <= 109) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 109 && sis < 133) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 133) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 30 && age <= 34) {
      //30-34
      //Ваше нормльное давление

      if (sis! <= 110) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 110 && sis < 134) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 134) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 35 && age <= 39) {
      //35-39
      //Ваше нормльное давление

      if (sis! <= 111) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 111 && sis < 135) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 135) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 40 && age <= 44) {
      //40-44
      //Ваше нормльное давление

      if (sis! <= 112) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 112 && sis < 137) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 137) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 45 && age <= 49) {
      //45-49
      //Ваше нормльное давление

      if (sis! <= 115) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 115 && sis < 139) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 139) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 50 && age <= 54) {
      //50-54
      //Ваше нормльное давление

      if (sis! <= 116) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 116 && sis < 142) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 142) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 55 && age <= 59) {
      //55-59
      //Ваше нормльное давление

      if (sis! <= 118) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 118 && sis < 144) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 144) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 60 && age <= 64) {
      //60-64
      //Ваше нормльное давление

      if (sis! <= 121) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 121 && sis < 147) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 147) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    } else if (age >= 65) {
      //65 >
      //Ваше нормльное давление

      if (sis! <= 123) {
        // ваше верхнне давление понижено
        infoTestSIS = sisText1;
      } else if (sis > 123 && sis < 150) {
        // ваше верхнне давление в норме
        infoTestSIS = sisText2;
      } else if (sis >= 150) {
        // ваше верхнне давление завышено
        infoTestSIS = sisText3;
      }
    }
  }

//НИЖНЕЕ
  void imputDis() {
    int? age = int.tryParse(ageInput.text);
    int? dis = int.tryParse(disInput.text);
    String disText1 = "понижено";
    String disText2 = "норма";
    String disText3 = "повышено";
    if (age! <= 19) {
      //Ваше нормльное давление

      if (dis! <= 73) {
        //14-19
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 73 && dis < 81) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 81) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 20 && age <= 24) {
      //20-24
      //Ваше нормльное давление

      if (dis! <= 75) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 75 && dis < 83) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 83) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 25 && age <= 29) {
      //25-29
      //Ваше нормльное давление

      if (dis! <= 76) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 76 && dis < 84) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 84) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 30 && age <= 34) {
      //30-34
      //Ваше нормльное давление

      if (dis! <= 77) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 77 && dis < 85) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 85) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 35 && age <= 39) {
      //35-39
      //Ваше нормльное давление

      if (dis! <= 78) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 78 && dis < 86) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 86) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 40 && age <= 44) {
      //40-44
      //Ваше нормльное давление

      if (dis! <= 79) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 79 && dis < 87) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 87) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 45 && age <= 49) {
      //45-49
      //Ваше нормльное давление

      if (dis! <= 80) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 80 && dis < 88) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 88) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 50 && age <= 54) {
      //50-54
      //Ваше нормльное давление

      if (dis! <= 81) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 81 && dis < 89) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 89) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 55 && age <= 59) {
      //55-59
      //Ваше нормльное давление

      if (dis! <= 82) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 82 && dis < 90) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 90) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 60 && age <= 64) {
      //60-64
      //Ваше нормльное давление

      if (dis! <= 83) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 83 && dis < 91) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 91) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    } else if (age >= 65) {
      //65 >
      //Ваше нормльное давление

      if (dis! <= 84) {
        // ваше верхнне давление понижено
        infoTestDIS = disText1;
      } else if (dis > 84 && dis < 92) {
        // ваше верхнне давление в норме
        infoTestDIS = disText2;
      } else if (dis >= 92) {
        // ваше верхнне давление завышено
        infoTestDIS = disText3;
      }
    }
  }

//ВЕРХНЕЕ
  void impuAge() {
    int? age = int.tryParse(ageInput.text);

    if (age! <= 19) {
      //Ваше нормльное давление
      infoAge = "117 / 77";
    } else if (age >= 20 && age <= 24) {
      //20-24
      //Ваше нормльное давление
      infoAge = "120 / 79";
    } else if (age >= 25 && age <= 29) {
      //25-29
      //Ваше нормльное давление
      infoAge = "121 / 80";
    } else if (age >= 30 && age <= 34) {
      //30-34
      //Ваше нормльное давление
      infoAge = "122 / 81";
    } else if (age >= 35 && age <= 39) {
      //35-39
      //Ваше нормльное давление
      infoAge = "123 / 82";
    } else if (age >= 40 && age <= 44) {
      //40-44
      //Ваше нормльное давление
      infoAge = "125 / 83";
    } else if (age >= 45 && age <= 49) {
      //45-49
      //Ваше нормльное давление
      infoAge = "127 / 84";
    } else if (age >= 50 && age <= 54) {
      //50-54
      //Ваше нормльное давление
      infoAge = "129 / 85";
    } else if (age >= 55 && age <= 59) {
      //55-59
      //Ваше нормльное давление
      infoAge = "131 / 86";
    } else if (age >= 60 && age <= 64) {
      //60-64
      //Ваше нормльное давление
      infoAge = "134 / 87";
    } else if (age >= 65) {
      //65 >
      //Ваше нормльное давление
      infoAge = "136 / 88";
    }
  }
}
