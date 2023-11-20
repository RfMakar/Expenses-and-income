class AnaliticsByMonth {
  final int month;
  final double expense;
  final double income;
  final double total;

  AnaliticsByMonth({
    required this.month,
    required this.expense,
    required this.income,
    required this.total,
  });
  //Чтение БД
  factory AnaliticsByMonth.fromMap(Map<String, dynamic> json) =>
      AnaliticsByMonth(
        month: json['month'],
        expense: json['expense'],
        income: json['income'],
        total: json['total'],
      );
}
