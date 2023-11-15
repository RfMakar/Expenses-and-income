import 'package:budget/repositories/finance/sqlite/db_finance.dart';

class ModelPageDataApp {
  void onTapDeleteAll() {
    //Удалить всe категории, тем самым все данные
    DBFinance.deleteTableCategory();
  }

  void onTapDeleteAllOperation() {
    //Удалить все операции
    DBFinance.deleteAllOperation();
  }
}
