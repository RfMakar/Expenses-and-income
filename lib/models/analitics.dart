import 'package:intl/intl.dart';

class Analitics {
  final int year;
  final List<AnaliticsMonth> listAnaliticsMonth;
  final List<AnaliticsAVGMonth> listAnaliticsAVGMonthExp;
  final List<AnaliticsAVGMonth> listAnaliticsAVGMonthInc;

  Analitics({
    required this.year,
    required this.listAnaliticsMonth,
    required this.listAnaliticsAVGMonthExp,
    required this.listAnaliticsAVGMonthInc,
  });

  //Сумма расходов за месяц
  String totalExpencec(int index) {
    var expenses = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      expenses += analiticsMonth.expense;
    }
    return NumberFormat.compact(locale: 'ru-RU').format(expenses);
  }

  //Сумма доходов за месяц
  String totalIncome(int index) {
    var income = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      income += analiticsMonth.income;
    }
    return NumberFormat.compact(locale: 'ru-RU').format(income);
  }

  //Сумма итого за год
  String totalTotal(int index) {
    var total = 0.0;
    for (var analiticsMonth in listAnaliticsMonth) {
      total += analiticsMonth.total;
    }
    return NumberFormat.compact(locale: 'ru-RU').format(total);
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

class AnaliticsAVGMonth {
  final String namecategory;
  final double avgcategory;

  AnaliticsAVGMonth({
    required this.namecategory,
    required this.avgcategory,
  });

  //Чтение БД
  factory AnaliticsAVGMonth.fromMap(Map<String, dynamic> json) =>
      AnaliticsAVGMonth(
        namecategory: json['namecategory'],
        avgcategory: json['avgcategory'],
      );
  String getAVGCategory() {
    return NumberFormat.compact(locale: 'ru-RU').format(avgcategory);
  }
}

class AnaliticsYear {
  final int year;

  AnaliticsYear({required this.year});

  //Чтение БД
  factory AnaliticsYear.fromMap(Map<String, dynamic> json) =>
      AnaliticsYear(year: json['year']);
}
