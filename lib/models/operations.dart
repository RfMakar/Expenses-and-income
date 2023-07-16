class Operations {
  int? id;
  int? idsubcategories;
  final String date;
  int? year;
  int? month;
  int? day;
  final double value;
  final String note;

  Operations({
    this.id,
    this.idsubcategories,
    required this.date,
    this.year,
    this.month,
    this.day,
    required this.value,
    required this.note,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idsubcategories': idsubcategories,
      'date': date,
      'year': year,
      'month': month,
      'day': day,
      'value': value,
      'note': note,
    };
  }

  //  //Чтение БД
  // factory Operations.fromMap(Map<String, dynamic> json) => Operations(
  //       id: json['id'],
  //       name: json['name'],
  //       color: json['color'],
  //     );
}
