import 'package:budget/model/budget.dart';
import 'package:budget/database/budget/db_budget.dart';
import 'package:budget/model/category.dart';
import 'package:flutter/material.dart';
import 'package:budget/screen/add/selection_category/screen_selection_category.dart';
import 'package:budget/screen/add/selection_subcategory/screen_selection_subcategory.dart';
import 'package:budget/screen/widget/my_widget.dart';

class ModelScreenNewEditBudget extends ChangeNotifier {
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;
  late Budget newBudget;
  late Budget editBudget;
  var isSelectedBudget = [true, false];
  final focusNode = FocusNode();
  final focusNodeCom = FocusNode();
  final sumControler = TextEditingController();
  final commentControler = TextEditingController();
  var validateTextField = false;

  DateTime get dateTime => _dateTime ?? DateTime.now();
  TimeOfDay get timeOfDay => _timeOfDay ?? TimeOfDay.now();

  String get nameButCat =>
      newBudget.category == null ? 'Выбрать' : newBudget.category!;
  String get nameButSubCat => newBudget.subcategory ?? 'Выбрать';

  ModelScreenNewEditBudget() {
    newBudget = Budget();
  }
  ModelScreenNewEditBudget.edit(Budget budget, this.isSelectedBudget) {
    _dateTime = DateTime(budget.year!, budget.month!, budget.day!);
    _timeOfDay = TimeOfDay(hour: budget.hour!, minute: budget.minute!);
    newBudget = Budget.clone(budget);
    editBudget = Budget.clone(budget);
    sumControler.text = budget.sum.toString();
    commentControler.text = budget.comment!;
  }

  void onPressedButExpensesIncome(int index) {
    for (int i = 0; i < isSelectedBudget.length; i++) {
      if (index == i) {
        isSelectedBudget[i] = true;
      } else {
        isSelectedBudget[i] = false;
      }
    }
    newBudget.category = null;
    newBudget.color = null;
    newBudget.subcategory = null;
    validateTextField = false;
    notifyListeners();
  }

  void onChangedDate(DateTime dateTime) {
    _dateTime = dateTime;
  }

  void onChangedTime(TimeOfDay timeOfDay) {
    _timeOfDay = timeOfDay;
  }

  void navigateScreenSelectionCategory(BuildContext context) async {
    final Category? category = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ScreenSelectionCategory(isSelectedBudget: isSelectedBudget)),
    );
    if (category != null) {
      newBudget.category = category.name;
      newBudget.color = category.color;
      newBudget.subcategory = null;
      notifyListeners();
    } else {
      newBudget.category = null;
      newBudget.color = null;
      newBudget.subcategory = null;
      notifyListeners();
    }
  }

  void navigateScreenSelectionSubcategory(BuildContext context) async {
    if (newBudget.category != null) {
      final categor = Category.sub(
          name: newBudget.category!, subname: null, color: newBudget.color!);
      final Category? category = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenSelectionSubcategory(
            category: categor,
            isSelectedBudget: isSelectedBudget,
          ),
        ),
      );
      if (category != null) {
        newBudget.subcategory = category.subname;
        notifyListeners();
      } else {
        newBudget.subcategory = null;
        notifyListeners();
      }
    } else {

      MyWidget.mySnackBar(context, 'Выберите категорию');
    }
  }

  void _newBudget() {
    newBudget.year = dateTime.year;
    newBudget.month = dateTime.month;
    newBudget.day = dateTime.day;
    newBudget.hour = timeOfDay.hour;
    newBudget.minute = timeOfDay.minute;
    newBudget.sum =
        double.parse((double.parse(sumControler.text)).toStringAsFixed(2));
    newBudget.comment = commentControler.text;
    newBudget.subcategory ??= '';
  }

  void _errorTextField() {
    validateTextField = true;
    notifyListeners();
  }

  void onPressedButtonAddBudget(BuildContext context) {
    if (sumControler.text.isNotEmpty && newBudget.category != null) {
      _newBudget();

      if (isSelectedBudget[0]) {
        DBBudget.insert('exptab', newBudget);
      } else {
        DBBudget.insert('inctab', newBudget);
      }
      focusNode.unfocus();
      focusNodeCom.unfocus();
      sumControler.clear();
      commentControler.clear();
      validateTextField = false;
      notifyListeners();
    } else if (newBudget.category == null) {
      MyWidget.mySnackBar(context, 'Выберите категорию');
    } else {
      _errorTextField();
    }
  }

  void onPressedButtonUpdateBudget(BuildContext context) {
    if (sumControler.text.isNotEmpty && newBudget.category != null) {
      _newBudget();

      if (isSelectedBudget[0]) {
        DBBudget.update('exptab', newBudget, editBudget);
      } else {
        DBBudget.update('inctab', newBudget, editBudget);
      }

      Navigator.pop(context);
    } else if (newBudget.category == null) {
      MyWidget.mySnackBar(context, 'Выберите категорию');
    } else {
      _errorTextField();
    }
  }
}
