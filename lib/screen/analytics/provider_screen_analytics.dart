import 'package:budget/models/analitics.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenAnalytics extends ChangeNotifier {
  List<Analitics> listAnalitics = [];

  String titleTable(int index) {
    return listAnalitics[index].year.toString();
  }

  List<AnaliticsMonth> getListAnaliticsMonth(int index) {
    return listAnalitics[index].listAnaliticsMonth;
  }

  int year(int index) {
    return listAnalitics[index].year;
  }

  Analitics analitics(int index) {
    return listAnalitics[index];
  }

  String totalExpencec(int index) {
    return analitics(index).totalExpencec(index);
  }

  String totalIncome(int index) {
    return analitics(index).totalIncome(index);
  }

  String totalTotal(int index) {
    return analitics(index).totalTotal(index);
  }

  Future getListYear() async {
    final listYear = await DBFinance.getListAnaliticsYear();

    for (var year in listYear) {
      final analitics = Analitics(year: year.year, listAnaliticsMonth: []);
      for (var i = 0; i <= 12; i++) {
        final listAnalitics =
            await DBFinance.getListAnaliticsMonth(year.year, i);

        if (listAnalitics.isNotEmpty) {
          analitics.listAnaliticsMonth.add(listAnalitics.first);
        }
      }
      listAnalitics.add(analitics);
    }
  }
}



/*
 // String column1(int index, int indexMonth) {
  //   return list[index].listAnaliticsMonth[indexMonth].month.toString();
  // }

  // String column2(int index, int indexMonth) {
  //   return list[index].listAnaliticsMonth[indexMonth].expense.toString();
  // }

  // String column3(int index, int indexMonth) {
  //   return list[index].listAnaliticsMonth[indexMonth].income.toString();
  // }

  // String column4(int index, int indexMonth) {
  //   return list[index].listAnaliticsMonth[indexMonth].total.toString();
  // }

  for (var analitics in list) {
      print('Year: ${analitics.year}');
      for (var element in analitics.listAnaliticsMonth) {
        print(
            'Month: ${element.month} Exp: ${element.expense} Inc: ${element.income} total: ${element.total}');
      }
    }

*/