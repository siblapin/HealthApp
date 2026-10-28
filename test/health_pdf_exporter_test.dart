import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:health_app_new/core/constants/constants_icons.dart';
import 'package:health_app_new/data/models/data_result_card_model.dart';
import 'package:health_app_new/data/pdf/health_pdf_exporter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('PDF начинается с %PDF и содержит данные измерения', () async {
    final bytes = await HealthPdfExporter.build(
      measurements: [
        DataResultCardModel(
          sis: '142',
          dis: '91',
          puls: '88',
          iconStatus: bad,
          iconDay: night,
          medicineText: 'лозартан',
          date: DateTime(2026, 5, 1, 21, 15),
          hand: handRight,
        ),
      ],
    );

    expect(bytes.length, greaterThan(100));
    expect(latin1.decode(bytes.sublist(0, 4)), '%PDF');
  });

  test('PDF не содержит полей профиля с экрана Полезное', () async {
    final bytes = await HealthPdfExporter.build(
      measurements: [
        DataResultCardModel(
          sis: '120',
          dis: '80',
          puls: '70',
          iconStatus: '',
          iconDay: '',
          medicineText: '',
          date: DateTime(2026, 1, 1),
          hand: '',
        ),
      ],
    );
    final asLatin = latin1.decode(bytes, allowInvalid: true);
    expect(asLatin.contains('Профиль'), isFalse);
    expect(asLatin.contains('Оценка по возрасту'), isFalse);
  });
}
