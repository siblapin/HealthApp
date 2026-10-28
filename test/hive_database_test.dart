import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:health_app_new/data/data.dart';
import 'package:health_app_new/data/hive/adapters.dart';
import 'package:health_app_new/data/models/data_result_card_model.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('health_hive_');
    Hive.init(tempDir.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CardHealthAdapter());
    }
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  DataResultCardModel sample({String sis = '120'}) {
    return DataResultCardModel(
      sis: sis,
      dis: '80',
      puls: '70',
      iconStatus: 'assets/icons/good.svg',
      iconDay: 'assets/icons/morning.svg',
      medicineText: 'эналаприл',
      date: DateTime(2026, 10, 28, 9, 30),
      hand: 'assets/icons/ion_hand-left.svg',
    );
  }

  test('адаптер Hive сохраняет и читает все поля', () async {
    final db = DatabaseProvider();
    await db.openCardHealthBox();
    db.addCardHealthBox(sample());

    expect(db.box.length, 1);
    final stored = db.box.getAt(0)!;
    expect(stored.sis, '120');
    expect(stored.dis, '80');
    expect(stored.puls, '70');
    expect(stored.iconStatus, 'assets/icons/good.svg');
    expect(stored.iconDay, 'assets/icons/morning.svg');
    expect(stored.medicineText, 'эналаприл');
    expect(stored.hand, 'assets/icons/ion_hand-left.svg');
    expect(stored.date, DateTime(2026, 10, 28, 9, 30));
  });

  test('удаление по индексу', () async {
    final db = DatabaseProvider();
    await db.openCardHealthBox();
    db.addCardHealthBox(sample(sis: '110'));
    db.addCardHealthBox(sample(sis: '130'));
    expect(db.box.length, 2);

    db.delCardHealth(0);
    expect(db.box.length, 1);
    expect(db.box.getAt(0)!.sis, '130');
  });

  test('повторный openCardHealthBox не падает', () async {
    final db = DatabaseProvider();
    await db.openCardHealthBox();
    await db.openCardHealthBox();
    expect(db.box.isOpen, isTrue);
  });
}
