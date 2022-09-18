import 'package:flutter/material.dart';

abstract class FormatDateTime {
  //Вернуть формат даты '01 янв 2022'
  static String getFormatDateDayMonthYear(DateTime dateTime) {
    final day = _toPadLeft(dateTime.day);
    final month = _getFormatDateMonth(dateTime.month);
    final year = _toPadLeft(dateTime.year);

    return '$day $month $year';
  }

  //Возращает формат времени '10:10'
  static String getFormatTimeHourMinute(TimeOfDay timeOfDay) {
    final hour = _toPadLeft(timeOfDay.hour);
    final minute = _toPadLeft(timeOfDay.minute);
    return '$hour:$minute';
  }

  //Возращает формат '01'
  static String _toPadLeft(int? number) {
    return number.toString().padLeft(2, '0');
  }

  //Вернуть формат месяца 'янв.'
  static String _getFormatDateMonth(int? month) {
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
}
