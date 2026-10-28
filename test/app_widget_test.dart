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
    tempDir = await Directory.systemTemp.createTemp('health_widget_');
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

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: db),
          ...providersApp,
        ],
        child: const HomeApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('на старте видна Главная, не Полезное', (tester) async {
    await pumpApp(tester);
    expect(find.text('СПИСОК ПУСТ'), findsOneWidget);
    expect(find.text('Сохранить в PDF'), findsNothing);
  });

  testWidgets('тап Полезное открывает экран с PDF', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Полезное'));
    await tester.pumpAndSettle();
    expect(find.text('Сохранить в PDF'), findsOneWidget);
    expect(find.text('ИНФОРМАЦИЯ'), findsOneWidget);
  });

  testWidgets('пустой Hive: PDF показывает SnackBar', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Полезное'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Сохранить в PDF'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Сохранить в PDF'));
    await tester.pump();
    expect(find.text('Нет сохранённых измерений'), findsOneWidget);
  });
}
