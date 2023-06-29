import 'package:budget/model/categories.dart';
import 'package:budget/model/subcategories.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:budget/const/db.dart';
import 'package:flutter/material.dart';

class ProviderScreenAddFinance extends ChangeNotifier {
  List<bool> finance = [true, false]; //Расход_Доход
  late List<Categories> listCategories;

  int financeSwitch() {
    return finance[0] == true ? 0 : 1;
  }

  Categories selectCategories(int index) {
    return listCategories[index];
  }

  Future getListCategories() async {
    final maps = await DBFinance.rawQuery(
        DBTableCategories.getList(), [financeSwitch()]);
    final List<Categories> list =
        maps.isNotEmpty ? maps.map((e) => Categories.fromMap(e)).toList() : [];
    listCategories = list;
  }

  void updateScreen() async {
    notifyListeners();
  }

  void onPressedSwitchExpInc(List<bool> list) {
    finance = list;
    updateScreen();
  }
}

class ProviderWidgetCardCategory extends ChangeNotifier {
  ProviderWidgetCardCategory(this.categories);
  final Categories categories;

  String nameCategories() {
    return categories.name;
  }

  Color colorCategories() {
    return Color(int.parse(categories.color));
  }

  String key() {
    return categories.id.toString();
  }

  List<String> listNameSubcategories() {
    return categories.listSubcategories!.map((e) => e.name).toList();
  }

  void updateWidget() async {
    notifyListeners();
  }

  Future getListSubCategories() async {
    final maps = await DBFinance.rawQuery(
        DBTableSubCategories.getList(), [categories.id]);
    final List<SubCategories> listSubCategoties = maps.isNotEmpty
        ? maps.map((e) => SubCategories.fromMap(e)).toList()
        : [];
    categories.listSubcategories = listSubCategoties;
  }
}


/*

 void onPressedButtonAddSubCategories(int index) async {
    final subCategories =
        SubCategories(idcategories: listCategories[index].id, name: 'dd');
    await DBFinance.insert(DBTableSubCategories.name, subCategories.toMap());
    notifyListeners();
  }


  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  // var buttonCarouselController = CarouselController();
  // final textEditingControllerValue = TextEditingController();

  // DateTime get dateTime => _dateTime ?? DateTime.now();
  // TimeOfDay get timeOfDay => _timeOfDay ?? TimeOfDay.now();

  late List<Account> listAccounts;

  void onTapAccount(int index) async {}

  Color colorAccount(int index) {
    return Color(int.parse(listAccounts[index].color));
  }

  String nameAccount(int index) {
    return listAccounts[index].name;
  }

  String valueAccount(int index) {
    return '${listAccounts[index].value} Р';
  }

 void onChangedDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void onChangedTime(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
  }


*/