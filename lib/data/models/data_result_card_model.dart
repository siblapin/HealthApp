//Класс с переменными
class DataResultCardModel {
  String sis; // СИС показатель из TextField
  String dis; // ДИС показатель из TextField
  String puls; // Пульс показатель из TextField
  String iconStatus; // адрес Иконки самочувствия
  String iconDay; // адрес иконки день самочувствия
  String medicineText; // название лекарств
  DateTime date;
  String hand;

  DataResultCardModel({
    required this.sis,
    required this.dis,
    required this.puls,
    required this.iconStatus,
    required this.iconDay,
    required this.medicineText,
    required this.date,
    required this.hand,
  });
}