import 'package:budget/features/shop_list/pages/shop_list/page_shop_list.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:budget/repositories/finance/sqllite/db_budget.dart';
import 'package:budget/repositories/finance/sqllite/db_finance.dart';
import 'package:budget/screens/app_finance/finance/screen_finance.dart';
import 'package:flutter/material.dart';

class ProviderScreenHome extends ChangeNotifier {
  ProviderScreenHome() {
    //Для переноса данных из старой базы в новую
    const nameExptab = 'exptab'; //Расходы
    const nameInctab = 'inctab'; //Доходы
    loadDB(nameExptab, 0);
    loadDB(nameInctab, 1);
  }
  int selectedIndex = 1;
  final List<Widget> _listWidgetScreen = const [
    ScreenFinance(),
    PageShopList(),
  ];
  final List<String> _listNameAppBar = const ['Финансы', 'Списки'];

  Widget widgetScreen() {
    return _listWidgetScreen[selectedIndex];
  }

  void updateScreen() {
    notifyListeners();
  }

  String titleAppBar() {
    return _listNameAppBar[selectedIndex];
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  //
  //Перенос данны, после обновления можно удалить
  //

  Future loadDB(String nameTable, int idFinance) async {
    //Получаем лист старых категорий
    final listCat = await DBBudget.getListCat(nameTable);

    //Проверям наличие данных
    if (listCat.isEmpty) {
      //Данных нет
    } else {
      //Есть старые данные
      await one(listCat, idFinance);
      await two(nameTable, idFinance);
      await three(nameTable, idFinance);
      await four(nameTable);
    }
  }

  Future four(String nameTable) async {
    await DBBudget.deleteTable(nameTable);
  }

  Future three(String nameTable, int idFinance) async {
    //Получаем список категорий
    final listCategory = await DBFinance.getListCategory(idFinance);

    //Получаем список подкатегорий для каждой категории
    for (var category in listCategory) {
      category.listSubCategories = await DBFinance.getListSubCategory(category);
    }

    for (var cat in listCategory) {
      for (var subcat in cat.listSubCategories!) {
        //Получаем список старых операций
        final listOper =
            await DBBudget.getListOper(cat.name, subcat.name, nameTable);
        for (var oper in listOper) {
          final WriteOperation writeOperation = WriteOperation(
            idSubcategory: subcat.id,
            date: DateTime(
                    oper.year, oper.month, oper.day, oper.hour, oper.minute)
                .toString(),
            year: oper.year,
            month: oper.month,
            day: oper.day,
            note: oper.comment,
            value: oper.sum,
          );
          //Записываем новые операции
          await DBFinance.insertOperation(writeOperation);
        }
      }
    }
  }

  Future two(String nameTable, int idFinance) async {
    //Получаем лист новых категорий
    final listCategory = await DBFinance.getListCategory(idFinance);
    for (var category in listCategory) {
      //Получаем лист подкатегорий для каждой категории из старой базы
      final listSubCat = await DBBudget.getListSubCat(category.name, nameTable);
      for (var subCat in listSubCat) {
        final WriteSubCategory writeSubCategory = WriteSubCategory(
          idCategory: category.id,
          name: subCat.subcategory,
        );
        //Записываем новые подкатегории в новую базу
        await DBFinance.insertSubCategory(writeSubCategory);
      }
    }
  }

  Future one(List<Cat> listCat, int idFinance) async {
    //Запись категорий в новую базу данных
    for (var cat in listCat) {
      final writeCategory = WriteCategory(
        idfinance: idFinance,
        name: cat.category,
        color: cat.color.toString(),
      );
      await DBFinance.insertCategory(writeCategory);
    }
  }
}
