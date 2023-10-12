class Analitics {
  final int year;
  final List<AnaliticsMonth> listAnaliticMonth;

  Analitics({required this.year, required this.listAnaliticMonth});
}

class AnaliticsYear {
  final int year;

  AnaliticsYear({
    required this.year,
  });

  //Чтение БД
  factory AnaliticsYear.fromMap(Map<String, dynamic> json) => AnaliticsYear(
        year: json['year'],
      );
}

class AnaliticsMonth {
  final num month;
  final double? expense;
  final double? income;
  final double? total;

  AnaliticsMonth({
    required this.month,
    required this.expense,
    required this.income,
    required this.total,
  });

  //Чтение БД
  factory AnaliticsMonth.fromMap(Map<String, dynamic> json) => AnaliticsMonth(
        month: json['month'],
        expense: json['expense'],
        income: json['income'],
        total: json['total'],
      );
}




/*
class AnaliticsMonth {
  final double expense;
  final double income;
  final double total;

  AnaliticsMonth({
    required this.expense,
    required this.income,
    required this.total,
  });

  //Чтение БД
  factory AnaliticsMonth.fromMap(Map<String, dynamic> json) => AnaliticsMonth(
        expense: json['expense'],
        income: json['income'],
        total: json['total'],
      );

*/