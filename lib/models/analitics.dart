import 'package:intl/intl.dart';

class Analitics {
  final int year;
  final List<AnaliticsMonth> listAnaliticsMonth;

  Analitics({required this.year, required this.listAnaliticsMonth});

  String totalExpencec(int index) {
    var expenses = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      expenses += analiticsMonth.expense;
    }
    return NumberFormat.compactSimpleCurrency(locale: 'ru-RU').format(expenses);
  }

  String totalIncome(int index) {
    var income = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      income += analiticsMonth.income;
    }
    return NumberFormat.compactSimpleCurrency(locale: 'ru-RU').format(income);
  }

  String totalTotal(int index) {
    var total = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      total += analiticsMonth.total;
    }
    return NumberFormat.compactSimpleCurrency(locale: 'ru-RU').format(total);
  }
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
  String getMonth(int year) {
    final dateTime = DateTime(year, month);
    return DateFormat.MMMM().format(dateTime);
  }

  String getExpence() {
    return NumberFormat.compact(locale: 'ru-RU').format(expense);
  }

  String getIncome() {
    return NumberFormat.compact(locale: 'ru-RU').format(income);
  }

  String getTotal() {
    return NumberFormat.compact(locale: 'ru-RU').format(total);
  }
}

class AnaliticsYear {
  final int year;

  AnaliticsYear({required this.year});

  //Чтение БД
  factory AnaliticsYear.fromMap(Map<String, dynamic> json) =>
      AnaliticsYear(year: json['year']);
}
