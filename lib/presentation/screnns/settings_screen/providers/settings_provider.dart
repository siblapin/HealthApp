import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AgeNorm {
  const _AgeNorm({
    required this.maxAge,
    required this.sisLow,
    required this.sisHighExclusive,
    required this.disLow,
    required this.disHighExclusive,
    required this.ageNormText,
  });

  final int maxAge;
  final int sisLow;
  final int sisHighExclusive;
  final int disLow;
  final int disHighExclusive;
  final String ageNormText;
}

const _ageNorms = [
  _AgeNorm(
    maxAge: 19,
    sisLow: 105,
    sisHighExclusive: 120,
    disLow: 73,
    disHighExclusive: 81,
    ageNormText: '117 / 77',
  ),
  _AgeNorm(
    maxAge: 24,
    sisLow: 108,
    sisHighExclusive: 132,
    disLow: 75,
    disHighExclusive: 83,
    ageNormText: '120 / 79',
  ),
  _AgeNorm(
    maxAge: 29,
    sisLow: 109,
    sisHighExclusive: 133,
    disLow: 76,
    disHighExclusive: 84,
    ageNormText: '121 / 80',
  ),
  _AgeNorm(
    maxAge: 34,
    sisLow: 110,
    sisHighExclusive: 134,
    disLow: 77,
    disHighExclusive: 85,
    ageNormText: '122 / 81',
  ),
  _AgeNorm(
    maxAge: 39,
    sisLow: 111,
    sisHighExclusive: 135,
    disLow: 78,
    disHighExclusive: 86,
    ageNormText: '123 / 82',
  ),
  _AgeNorm(
    maxAge: 44,
    sisLow: 112,
    sisHighExclusive: 137,
    disLow: 79,
    disHighExclusive: 87,
    ageNormText: '125 / 83',
  ),
  _AgeNorm(
    maxAge: 49,
    sisLow: 115,
    sisHighExclusive: 139,
    disLow: 80,
    disHighExclusive: 88,
    ageNormText: '127 / 84',
  ),
  _AgeNorm(
    maxAge: 54,
    sisLow: 116,
    sisHighExclusive: 142,
    disLow: 81,
    disHighExclusive: 89,
    ageNormText: '129 / 85',
  ),
  _AgeNorm(
    maxAge: 59,
    sisLow: 118,
    sisHighExclusive: 144,
    disLow: 82,
    disHighExclusive: 90,
    ageNormText: '131 / 86',
  ),
  _AgeNorm(
    maxAge: 64,
    sisLow: 121,
    sisHighExclusive: 147,
    disLow: 83,
    disHighExclusive: 91,
    ageNormText: '134 / 87',
  ),
  _AgeNorm(
    maxAge: 200,
    sisLow: 123,
    sisHighExclusive: 150,
    disLow: 84,
    disHighExclusive: 92,
    ageNormText: '136 / 88',
  ),
];

String _pressureLevel(int value, int low, int highExclusive) {
  if (value <= low) return 'понижено';
  if (value < highExclusive) return 'норма';
  return 'повышено';
}

_AgeNorm? _normForAge(int age) {
  for (final band in _ageNorms) {
    if (age <= band.maxAge) return band;
  }
  return null;
}

class SettingsProvider extends ChangeNotifier {
  bool yesnoGender = true;
  bool yesNoStatus = true;
  bool yesNoDay = true;
  bool yesNoHand = true;
  bool _disposed = false;

  SettingsProvider() {
    getPrefsSettings();
  }

  void _notify() {
    if (_disposed) return;
    notifyListeners();
  }

  String infoTestSIS = '';
  String infoTestDIS = '';
  String infoAge = '';

  String infosisSp = '';
  String infodisSp = '';
  String infopulsSp = '';
  String infoageSp = '';

  final TextEditingController sisInput = TextEditingController();
  final TextEditingController disInput = TextEditingController();
  final TextEditingController pulseInput = TextEditingController();
  final TextEditingController ageInput = TextEditingController();

  @override
  void dispose() {
    _disposed = true;
    sisInput.dispose();
    disInput.dispose();
    pulseInput.dispose();
    ageInput.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    infosisSp = sisInput.text;
    infodisSp = disInput.text;
    infopulsSp = pulseInput.text;
    infoageSp = ageInput.text;
    await prefs.setString('infoSIS', infosisSp);
    await prefs.setString('infoDIS', infodisSp);
    await prefs.setString('infoPulse', infopulsSp);
    await prefs.setString('infoAge', infoageSp);
    _notify();
  }

  Future<void> updateSisDisPuls() async {
    _notify();
  }

  Future<void> yesNo() async {
    final prefs = await SharedPreferences.getInstance();
    yesnoGender = !yesnoGender;
    await prefs.setBool('yesnoGender', yesnoGender);
    _notify();
  }

  Future<void> yesNoStatusF(bool a, int b) async {
    final prefs = await SharedPreferences.getInstance();
    switch (b) {
      case 1:
        yesNoStatus = !yesNoStatus;
        await prefs.setBool('yesNoStatus', yesNoStatus);
        break;
      case 2:
        yesNoDay = !yesNoDay;
        await prefs.setBool('yesNoDay', yesNoDay);
        break;
      case 3:
        yesNoHand = !yesNoHand;
        await prefs.setBool('yesNoHand', yesNoHand);
        break;
    }
    _notify();
  }

  Future<void> getPrefsSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (_disposed) return;
    yesnoGender = prefs.getBool('yesnoGender') ?? yesnoGender;
    yesNoStatus = prefs.getBool('yesNoStatus') ?? yesNoStatus;
    yesNoDay = prefs.getBool('yesNoDay') ?? yesNoDay;
    yesNoHand = prefs.getBool('yesNoHand') ?? yesNoHand;
    infosisSp = prefs.getString('infoSIS') ?? infosisSp;
    infodisSp = prefs.getString('infoDIS') ?? infodisSp;
    infopulsSp = prefs.getString('infoPulse') ?? infopulsSp;
    infoageSp = prefs.getString('infoAge') ?? infoageSp;
    sisInput.text = infosisSp;
    disInput.text = infodisSp;
    pulseInput.text = infopulsSp;
    ageInput.text = infoageSp;
    _notify();
  }

  void imputSis() {
    final age = int.tryParse(ageInput.text);
    final sis = int.tryParse(sisInput.text);
    if (age == null || sis == null) return;
    final band = _normForAge(age);
    if (band == null) return;
    infoTestSIS = _pressureLevel(sis, band.sisLow, band.sisHighExclusive);
  }

  void imputDis() {
    final age = int.tryParse(ageInput.text);
    final dis = int.tryParse(disInput.text);
    if (age == null || dis == null) return;
    final band = _normForAge(age);
    if (band == null) return;
    infoTestDIS = _pressureLevel(dis, band.disLow, band.disHighExclusive);
  }

  void impuAge() {
    final age = int.tryParse(ageInput.text);
    if (age == null) return;
    final band = _normForAge(age);
    if (band == null) return;
    infoAge = band.ageNormText;
  }
}
