import 'package:budget/models/analitics.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenAnalytics extends ChangeNotifier {
  List<Analitics> list = [];

  String titleTable(int index) {
    return list[index].year.toString();
  }

  Future getListYear() async {
    final listYear = await DBFinance.getListAnaliticsYear();

    for (var year in listYear) {
      for (var i = 0; i <= 12; i++) {
        final listAnaliticsMonth =
            await DBFinance.getListAnaliticsMonth(year.year, i);
        if (listAnaliticsMonth.isNotEmpty) {
          final analitics = Analitics(
              year: year.year, listAnaliticsMonth: listAnaliticsMonth);
          list.add(analitics);
        }
      }
    }

    for (var analitics in list) {
      print('Year: ${analitics.year}');
      for (var element in analitics.listAnaliticsMonth) {
        print(
            'Month: ${element.month} Exp: ${element.expense} Inc: ${element.income} total: ${element.total}');
      }
    }
  }
}
