import 'package:flutter/services.dart';
import 'package:health_app_new/core/constants/constants_icons.dart';
import 'package:health_app_new/data/models/data_result_card_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HealthPdfExporter {
  static String _dash(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? '—' : trimmed;
  }

  static String _moodLabel(String iconPath) {
    if (iconPath == bad) return 'Плохо';
    if (iconPath == depression) return 'Недомогание';
    if (iconPath == good) return 'Хорошо';
    if (iconPath == happy) return 'Отлично';
    return 'не указано';
  }

  static String _dayLabel(String iconPath) {
    if (iconPath == morning) return 'Утро';
    if (iconPath == day) return 'День';
    if (iconPath == night) return 'Вечер';
    return 'не указано';
  }

  static String _handLabel(String iconPath) {
    if (iconPath == handLeft) return 'Левая';
    if (iconPath == handRight) return 'Правая';
    return 'не указана';
  }

  static Future<Uint8List> build({
    required List<DataResultCardModel> measurements,
  }) async {
    final regularData = await rootBundle.load(
      'assets/fonts/NotoSans-Regular.ttf',
    );
    final boldData = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
    final regular = pw.Font.ttf(regularData);
    final bold = pw.Font.ttf(boldData);
    final createdAt = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());

    final theme = pw.ThemeData.withFont(base: regular, bold: bold);
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Дневник давления',
              style: pw.TextStyle(font: bold, fontSize: 20),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Сформировано: $createdAt',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.Divider(),
          ],
        ),
        footer: (context) => pw.Text(
          'Страница ${context.pageNumber} из ${context.pagesCount}',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        build: (context) => [
          pw.Text(
            'История измерений',
            style: pw.TextStyle(font: bold, fontSize: 16),
          ),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(font: bold, fontSize: 8),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey100,
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headers: const [
              'Дата',
              'Верхнее',
              'Нижнее',
              'Пульс',
              'Самочувствие',
              'Время суток',
              'Рука',
              'Лекарства',
            ],
            data: measurements
                .map(
                  (item) => [
                    DateFormat('dd.MM.yyyy HH:mm').format(item.date),
                    _dash(item.sis),
                    _dash(item.dis),
                    _dash(item.puls),
                    _moodLabel(item.iconStatus),
                    _dayLabel(item.iconDay),
                    _handLabel(item.hand),
                    _dash(item.medicineText),
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );

    return doc.save();
  }
}
