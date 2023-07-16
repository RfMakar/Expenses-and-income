class HistoryOperations {
  final int idoperations;
  final String namecategories;
  final String namesubcategories;
  final String date;
  final double value;

  HistoryOperations({
    required this.idoperations,
    required this.namecategories,
    required this.namesubcategories,
    required this.date,
    required this.value,
  });

  //Чтение БД
  factory HistoryOperations.fromMap(Map<String, dynamic> json) =>
      HistoryOperations(
        idoperations: json['idoperations'],
        namecategories: json['namecategories'],
        namesubcategories: json['namesubcategories'],
        date: json['date'],
        value: json['value'],
      );
}
