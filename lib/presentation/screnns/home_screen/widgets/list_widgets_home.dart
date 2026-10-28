import 'package:flutter/material.dart';
import 'package:health_app_new/data/data.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/result_card_model.dart';

class ListWidgetsHomeScreen extends StatelessWidget {
  const ListWidgetsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = context.watch<DatabaseProvider>().box;
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: box.isEmpty
            ? const Center(child: Text('СПИСОК ПУСТ'))
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final reversedIndex = box.length - 1 - index;
                  final item = box.getAt(reversedIndex);
                  if (item == null) return const SizedBox.shrink();
                  return ResultCardModel(
                    smail: item.iconStatus,
                    iconDay: item.iconDay,
                    sis: item.sis,
                    dis: item.dis,
                    puls: item.puls,
                    medicineText: item.medicineText,
                    date: DateFormat('dd.MM.yyyy').format(item.date),
                    index: reversedIndex,
                    hand: item.hand,
                  );
                },
              ),
      ),
    );
  }
}
