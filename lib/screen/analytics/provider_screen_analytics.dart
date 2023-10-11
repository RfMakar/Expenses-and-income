import 'package:budget/models/analitics.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenAnalytics extends ChangeNotifier {
  Future getListYear() async {
    final listAnaliticsYear = await DBFinance.getListAnaliticsYear();

    for (var analiticsYear in listAnaliticsYear) {
      final listAnaliticsMonth =
          await DBFinance.getListAnaliticsMonth(analiticsYear.year);
      for (var element in listAnaliticsMonth) {
        print(
            'Year: ${analiticsYear.year} Month: ${element.month} Exp: ${element.expense}');
        print(
            'Year: ${analiticsYear.year} Month: ${element.month} Inc: ${element.income}');
        print(
            'Year: ${analiticsYear.year} Month: ${element.month} Tot: ${element.total}');
      }
    }
  }
}


// for (var year in listYear) {
    //   final listMont = await DBFinance.getListMonth(year);

    //   //
    //   for (var month in listMont) {
    //     final listAnaliticMonth =
    //         await DBFinance.getListAnaliticMonth(year, month);

    //     final Map<int, AnaliticMonth> mapAnaliticMonth = {month:};
    //     final Analitics analitics =
    //         Analitics(year: year, mapAnaliticMonth: mapAnaliticMonth);
        // for (var analiticMonth in listAnaliticMonth) {

          // print(
          //     'Year: $year, Month: $month Расход: ${analiticMonth.expense} Доход: ${analiticMonth.income} Итого: ${analiticMonth.total}');
       // }
    //   }