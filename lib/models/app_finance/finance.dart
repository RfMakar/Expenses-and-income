//0 - расходы, 1 - доходы

class Finance {
  final String expense = 'Расход';
  final String income = 'Доход';
  List<bool> isSelected = [true, false];

  int get id => isSelected[0] == true ? 0 : 1;

  void onPressed(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (index == i) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
  }

  String titleFinance() {
    if (id == 0) {
      return expense;
    } else {
      return income;
    }
  }

  String titleAddFinance() {
    if (id == 0) {
      return 'Добавить ${expense.toLowerCase()}';
    } else {
      return 'Добавить ${income.toLowerCase()}';
    }
  }
}
