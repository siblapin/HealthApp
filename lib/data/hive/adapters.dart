import 'package:hive/hive.dart';
import '../models/data_result_card_model.dart';

class CardHealthAdapter extends TypeAdapter<DataResultCardModel> {
  @override
  final int typeId = 0;

  @override
  DataResultCardModel read(BinaryReader reader) {
    String sis = reader.readString(); // СИС показатель из TextField
    String dis = reader.readString(); // ДИС показатель из TextField
    String puls = reader.readString();
    String iconStatus = reader.readString(); // адрес Иконки самочувствия
    String iconDay = reader.readString(); // адрес иконки день самочувствия
    String hand = reader.readString();
    String medicineText = reader.readString();

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(reader.readInt());
    return DataResultCardModel(
        sis: sis,
        dis: dis,
        puls: puls,
        iconStatus: iconStatus,
        iconDay: iconDay,
        medicineText: medicineText,
        date: date,
        hand: hand);
  }

  @override
  void write(BinaryWriter writer, DataResultCardModel obj) {
    writer.writeString(obj.sis);
    writer.writeString(obj.dis);
    writer.writeString(obj.puls);
    writer.writeString(obj.iconStatus);
    writer.writeString(obj.iconDay);
    writer.writeString(obj.hand);
    writer.writeString(obj.medicineText);

    writer.writeInt(obj.date.microsecondsSinceEpoch);
  }
}
