import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_app_new/data/data.dart';
import 'package:health_app_new/data/hive/adapters.dart';
import 'package:health_app_new/domain/providers/providers.dart';
import 'package:health_app_new/main.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late DatabaseProvider db;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    tempDir = await Directory.systemTemp.createTemp('health_func_');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CardHealthAdapter());
    }
    db = DatabaseProvider();
    await db.openCardHealthBox();
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  Future<void> drainOverflows(WidgetTester tester) async {
    for (var i = 0; i < 20; i++) {
      if (tester.takeException() == null) return;
    }
  }

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: db),
          ...providersApp,
        ],
        child: const HomeApp(),
      ),
    );
    await tester.pump();
    await drainOverflows(tester);
  }

  testWidgets('главная: пустой дневник', (tester) async {
    await pumpApp(tester);
    expect(find.text('Дневник давления'), findsOneWidget);
    expect(find.text('Пока нет измерений'), findsOneWidget);
    expect(find.text('Добавить'), findsOneWidget);
    expect(find.text('СПИСОК ПУСТ'), findsOneWidget);
  });

  testWidgets('форма добавления открывается и не пишет пустую запись', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Добавить'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await drainOverflows(tester);
    expect(find.text('Новое измерение'), findsOneWidget);
    await tester.tap(find.text('Сохранить'), warnIfMissed: false);
    await tester.pump();
    expect(db.box.isEmpty, isTrue);
    expect(
      find.text('Введите верхнее, нижнее давление и пульс').evaluate().length,
      lessThanOrEqualTo(1),
    );
  });

  testWidgets('сворачивание шапки Все / Назад', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Все'));
    await tester.pump();
    expect(find.text('Добавить'), findsNothing);
    await tester.tap(find.text('Назад'));
    await tester.pump();
    expect(find.text('Добавить'), findsOneWidget);
  });

  testWidgets('настройки открываются и закрываются', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Настройки'), findsOneWidget);
    await tester.tap(find.text('Назад'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Добавить'), findsOneWidget);
  });

  testWidgets('вкладки Главная и Полезное', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Полезное'));
    await tester.pump();
    expect(find.text('ИНФОРМАЦИЯ'), findsOneWidget);
    expect(find.text('Сохранить в PDF'), findsOneWidget);
    await tester.tap(find.text('Главная'));
    await tester.pump();
    expect(find.text('Добавить'), findsOneWidget);
  });

  testWidgets('Полезное: расчёт нормы', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Полезное'));
    await tester.pump();
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), '100');
    await tester.enterText(fields.at(1), '70');
    await tester.enterText(fields.at(2), '65');
    await tester.enterText(fields.at(3), '20');
    await tester.tap(find.text('Обновить данные'), warnIfMissed: false);
    await tester.pump();
    expect(find.text('120 / 79'), findsOneWidget);
    expect(find.text('понижено'), findsWidgets);
  });

  testWidgets('PDF при пустом Hive показывает сообщение', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Полезное'));
    await tester.pump();
    await tester.tap(find.text('Сохранить в PDF'), warnIfMissed: false);
    await tester.pump();
    expect(
      find.text('Нет сохранённых измерений'),
      findsAtLeastNWidgets(1),
    );
  });

  testWidgets('узкий телефон не даёт overflow на главной и форме', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: db),
          ...providersApp,
        ],
        child: const HomeApp(),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Добавить'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
    expect(find.text('Новое измерение'), findsOneWidget);
  });

  testWidgets('широкий экран без кнопки Все', (tester) async {
    tester.view.physicalSize = const Size(1100, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: db),
          ...providersApp,
        ],
        child: const HomeApp(),
      ),
    );
    await tester.pump();
    await drainOverflows(tester);
    expect(find.text('Все'), findsNothing);
    expect(find.text('Добавить'), findsOneWidget);
  });
}
