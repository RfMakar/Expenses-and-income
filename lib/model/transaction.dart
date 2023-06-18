class Transactions {
  int? id;
  final int idAccount;
  int? idSubCategories;
  final String date;
  final int year;
  final int month;
  final int day;
  final double value;
  String? note;

  Transactions({
    this.id,
    required this.idAccount,
    this.idSubCategories,
    required this.date,
    required this.year,
    required this.month,
    required this.day,
    required this.value,
    this.note,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idAccount': idAccount,
      'idSubCategories': idSubCategories,
      'date': date,
      'year': year,
      'month': month,
      'day': day,
      'value': value,
      'note': note,
    };
  }

  //Чтение БД
  // factory Transactions.fromMap(Map<String, dynamic> json) => Transactions(
  //       id: json['id'],
  //       name: json['name'],
  //       color: json['color'],
  //       value: json['value'],
  //     );
}
