class Analitics {
  final int year;
  final List<AnaliticsMonth> listAnaliticsMonth;

  Analitics({required this.year, required this.listAnaliticsMonth});
}

class AnaliticsMonth {
  final int month;
  final double expense;
  final double income;
  final double total;

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

class AnaliticsYear {
  final int year;

  AnaliticsYear({required this.year});

  //Чтение БД
  factory AnaliticsYear.fromMap(Map<String, dynamic> json) =>
      AnaliticsYear(year: json['year']);
}
