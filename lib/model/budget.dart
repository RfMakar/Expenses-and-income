import 'package:intl/intl.dart';

class Budget {
  String? category;
  String? subcategory;
  int? color;
  String? comment;
  double? sum;
  int? year;
  int? month;
  int? day;
  int? hour;
  int? minute;
  int? number;

  Budget({
    this.category,
    this.subcategory,
    this.color,
    this.comment,
    this.sum,
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.number,
  });

  Budget.clone(Budget budget) {
    category = budget.category;
    subcategory = budget.subcategory;
    color = budget.color;
    comment = budget.comment;
    sum = budget.sum;
    year = budget.year;
    month = budget.month;
    day = budget.day;
    hour = budget.hour;
    minute = budget.minute;
    number = budget.number;
  }

  //map to Expenses(full)
  factory Budget.fromMap(Map<String, dynamic> json) => Budget(
        category: json['category'],
        subcategory: json['subcategory'],
        color: json['color'],
        comment: json['comment'],
        sum: json['sum'],
        year: json['year'],
        month: json['month'],
        day: json['day'],
        hour: json['hour'],
        minute: json['minute'],
        number: json['number'],
      );

  //map to Expencses (categoryExpenses, sumExpenses, numberExpenses )
  factory Budget.fromMapCategory(Map<String, dynamic> json) => Budget(
        category: json['category'],
        color: json['color'],
        sum: json['sum'],
        number: json['number'],
      );

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'subcategory': subcategory,
      'color': color,
      'comment': comment,
      'sum': sum,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'number': number,
    };
  }

  //Возращает формат '01'
  String toPadLeft(int? number) {
    return number.toString().padLeft(2, '0');
  }

  //Вернуть формат даты '01 янв.'
  String getFormatDateDayMonth() {
    final day = toPadLeft(this.day);
    final month = getFormatDateMonth(this.month);

    return '$day $month';
  }

  //Возращает формат времени '10:10'
  String getFormatTimeHourMinute() {
    final hour = toPadLeft(this.hour);
    final minute = toPadLeft(this.minute);
    return '$hour:$minute';
  }

  //Вернуть формат месяца 'янв.'
  String getFormatDateMonth(int? month) {
    switch (month) {
      case 1:
        return 'янв.';
      case 2:
        return 'фев.';
      case 3:
        return 'мар.';
      case 4:
        return 'апр.';
      case 5:
        return 'май';
      case 6:
        return 'июн.';
      case 7:
        return 'июл.';
      case 8:
        return 'авг.';
      case 9:
        return 'сен.';
      case 10:
        return 'окт.';
      case 11:
        return 'ноя.';
      case 12:
        return 'дек.';
      default:
        return '';
    }
  }

  //Формат числа "1 345 450,56 Р"
  String getFormatSumExpenses() {
    var str = NumberFormat.currency(locale: 'ru', symbol: '₽').format(sum);
    return str;
  }
}
