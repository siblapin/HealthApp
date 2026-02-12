import 'package:flutter/cupertino.dart';
import 'package:health_app_new/data/data.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../widgets/result_card_model.dart';

class ListWidgetsHomeScreen extends StatelessWidget {
  const ListWidgetsHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
              future: context.watch<DatabaseProvider>().openCardHealthBox(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CupertinoActivityIndicator());
                } else {
                  final box = context.read<DatabaseProvider>().box;
                  if (box.isNotEmpty) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        index = box.length - 1 - index;
                        return ResultCardModel(
                          smail: box.getAt(index)?.iconStatus.toString() ?? '',
                          iconDay: box.getAt(index)?.iconDay.toString() ?? '',
                          sis: box.getAt(index)?.sis.toString() ?? '',
                          dis: box.getAt(index)?.dis.toString() ?? '',
                          puls: box.getAt(index)?.puls.toString() ?? '',
                          medicineText:
                              box.getAt(index)?.medicineText.toString() ?? '',
                          date: DateFormat('dd.MM.yyyy')
                              .format(box.getAt(index)?.date ?? DateTime.now()),
                          index: index,
                          hand: box.getAt(index)?.hand.toString() ?? '',
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("СПИСОК ПУСТ"));
                  }
                }
              })),
    );
  }
}
