import 'package:flutter/material.dart';
import 'package:health_app_new/core/constants/constants_color.dart';
import 'package:health_app_new/data/data.dart';
import 'package:health_app_new/data/models/data_result_card_model.dart';
import 'package:health_app_new/data/pdf/health_pdf_exporter.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class ButtonSavePdf extends StatefulWidget {
  const ButtonSavePdf({super.key});

  @override
  State<ButtonSavePdf> createState() => _ButtonSavePdfState();
}

class _ButtonSavePdfState extends State<ButtonSavePdf> {
  bool _busy = false;

  Future<void> _export() async {
    if (_busy) return;
    setState(() => _busy = true);
    final box = context.read<DatabaseProvider>().box;

    final measurements = <DataResultCardModel>[];
    for (var i = box.length - 1; i >= 0; i--) {
      final item = box.getAt(i);
      if (item != null) measurements.add(item);
    }

    if (measurements.isEmpty) {
      if (mounted) {
        setState(() => _busy = false);
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          const SnackBar(content: Text('Нет сохранённых измерений')),
        );
      }
      return;
    }

    try {
      final bytes = await HealthPdfExporter.build(measurements: measurements);
      final fileName =
          'dnevnik-davleniya-${DateFormat('yyyyMMdd-HHmm').format(DateTime.now())}.pdf';
      await Printing.sharePdf(bytes: bytes, filename: fileName);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось создать PDF: $error')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(ColorBackgroundApp.color_100),
        ),
        onPressed: _busy ? null : _export,
        icon: _busy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(Icons.picture_as_pdf, color: ColorBackgroundApp.bg),
        label: Text(
          _busy ? 'Готовим PDF...' : 'Сохранить в PDF',
          style: TextStyle(color: ColorBackgroundApp.bg, fontSize: 18),
        ),
      ),
    );
  }
}
