import 'package:budget/repositories/finance/models/analitics.dart';
import 'package:budget/repositories/finance/sqlite/db_finance.dart';
import 'package:flutter/material.dart';

class ModelPageAnalytics extends ChangeNotifier {
  var _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  void onPressedButSwitchDateBack() {
    //Если год 2021 то дата переключится на год назад
    var enabledButton = (_dateTime.year == 2021);
    if (!enabledButton) {
      _dateTime = DateTime(_dateTime.year - 1);
    }
    notifyListeners();
  }

  void onPressedButSwitchDateNext() {
    //Если год не текущий то прибавь год
    final enabledButton = (_dateTime.year == DateTime.now().year);
    if (!enabledButton) {
      _dateTime = DateTime(_dateTime.year + 1);
    }
    notifyListeners();
  }
}


/*
List<Analitics> listAnalitics = [];

  Future getListAnalitics() async {
    //Список всех лет
    final listYear = await DBFinance.getListAnaliticsYear();

    for (var year in listYear) {
      final analitics = Analitics(
          year: year.year,
          listAnaliticsMonth: [],
          listAnaliticsAVGMonthExp: [],
          listAnaliticsAVGMonthInc: []);

      for (var i = 1; i <= 12; i++) {
        //Для каждого месяца получаем лист аналитики
        final listAnalitics =
            await DBFinance.getListAnaliticsMonth(year.year, i);
        //Добавить в analitics
        if (listAnalitics.isNotEmpty) {
          analitics.listAnaliticsMonth.add(listAnalitics.first);
        }
      }

      //Получаем лист аналитики средних значений по категориям за год и добавдяем в аналитику
      analitics.listAnaliticsAVGMonthExp.addAll(
        await DBFinance.getListAnaliticsAVGMonth(year.year, 0),
      );
      analitics.listAnaliticsAVGMonthInc.addAll(
        await DBFinance.getListAnaliticsAVGMonth(year.year, 1),
      );
      //Добавляем аналитику в лист Аналитики
      listAnalitics.add(analitics);
    }
  }

  String titleTableMonth(int index) {
    return 'Финансы';
  }

  String titleTableAVGMonthExp(int index) {
    return 'Средний расход в месяц';
  }

  String titleTableAVGMonthInc(int index) {
    return 'Средний доход в месяц';
  }

  List<AnaliticsMonth> getListAnaliticsMonth(int index) {
    return listAnalitics[index].listAnaliticsMonth;
  }

  List<AnaliticsAVGMonth> getListAnaliticsAVGMonthExp(int index) {
    return listAnalitics[index].listAnaliticsAVGMonthExp;
  }

  List<AnaliticsAVGMonth> getListAnaliticsAVGMonthInc(int index) {
    return listAnalitics[index].listAnaliticsAVGMonthInc;
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
*/