import 'package:flutter_test/flutter_test.dart';
import 'package:health_app_new/presentation/screnns/settings_screen/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('пустые поля не роняют расчёт нормы', () async {
    final settings = SettingsProvider();
    await settings.getPrefsSettings();
    expect(() {
      settings.imputSis();
      settings.imputDis();
      settings.impuAge();
    }, returnsNormally);
    expect(settings.infoTestSIS, isEmpty);
    expect(settings.infoTestDIS, isEmpty);
    expect(settings.infoAge, isEmpty);
    settings.dispose();
  });

  test('норма SIS для 20 лет: 108 и ниже — понижено, 120 — норма, 132 — повышено', () async {
    final settings = SettingsProvider();
    await settings.getPrefsSettings();
    settings.ageInput.text = '20';

    settings.sisInput.text = '108';
    settings.imputSis();
    expect(settings.infoTestSIS, 'понижено');

    settings.sisInput.text = '120';
    settings.imputSis();
    expect(settings.infoTestSIS, 'норма');

    settings.sisInput.text = '132';
    settings.imputSis();
    expect(settings.infoTestSIS, 'повышено');

    settings.impuAge();
    expect(settings.infoAge, '120 / 79');
    settings.dispose();
  });

  test('сохранённые prefs читаются в infosisSp', () async {
    SharedPreferences.setMockInitialValues({
      'infoSIS': '118',
      'infoDIS': '76',
      'infoPulse': '70',
      'infoAge': '33',
    });
    final settings = SettingsProvider();
    await settings.getPrefsSettings();
    expect(settings.infosisSp, '118');
    expect(settings.infodisSp, '76');
    expect(settings.infopulsSp, '70');
    expect(settings.infoageSp, '33');
    settings.dispose();
  });

  test('поля ввода заполняются из prefs после загрузки', () async {
    SharedPreferences.setMockInitialValues({'infoSIS': '118', 'infoAge': '33'});
    final settings = SettingsProvider();
    await settings.getPrefsSettings();
    expect(settings.sisInput.text, '118');
    expect(settings.ageInput.text, '33');
    settings.dispose();
  });
}
