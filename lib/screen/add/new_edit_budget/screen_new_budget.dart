import 'package:flutter/material.dart';
import 'package:budget/screen/widget/button_select_category.dart';
import 'package:budget/screen/widget/button_select_subcategory.dart';
import 'package:budget/screen/widget/buttons_add_edit_expenses.dart';
import 'package:budget/screen/widget/buttons_date_time.dart';
import 'package:budget/screen/widget/buttons_expenses_income.dart';
import 'package:budget/screen/widget/textfield_sum_comment.dart';
import 'package:provider/provider.dart';
import 'model_new_edit_budget.dart';

class ScreenNewBudget extends StatelessWidget {
  const ScreenNewBudget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelScreenNewEditBudget(),
      child: Consumer<ModelScreenNewEditBudget>(
        builder: (context, model, _) {
          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              ButtonsExpensesIncome(
                isSelected: model.isSelectedBudget,
                onPressed: model.onPressedButExpensesIncome,
              ),
              ButtonsDateTime(
                dateTime: model.dateTime,
                timeOfDay: model.timeOfDay,
                onChangedDate: model.onChangedDate,
                onChangedTime: model.onChangedTime,
              ),
              const Divider(),
              ButtonSelectCategory(
                name: model.nameButCat,
                onPressed: () => model.navigateScreenSelectionCategory(context),
              ),
              const Divider(),
              ButtonSelectSubcategory(
                name: model.nameButSubCat,
                onPressed: () =>
                    model.navigateScreenSelectionSubcategory(context),
              ),
              const Divider(),
              TextFieldSumComment(
                textControllerSum: model.sumControler,
                textControllerComment: model.commentControler,
                validate: model.validateTextField,
                focusNode: model.focusNode,
                focusNodeCom: model.focusNodeCom,
              ),
              const Divider(),
              ButtonsAddEditExpenses(
                nameButton: 'Добавить',
                icons: Icons.add,
                onPressed: () => model.onPressedButtonAddBudget(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
