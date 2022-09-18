import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/add/new_edit_budget/model_new_edit_budget.dart';
import 'package:budget/screen/widget/button_select_category.dart';
import 'package:budget/screen/widget/button_select_subcategory.dart';
import 'package:budget/screen/widget/buttons_add_edit_expenses.dart';
import 'package:budget/screen/widget/buttons_date_time.dart';
import 'package:budget/screen/widget/textfield_sum_comment.dart';
import 'package:provider/provider.dart';

class ScreenEditBudget extends StatelessWidget {
  final Budget editBudget;
  final List<bool> isSelectedBudget;

  const ScreenEditBudget(
      {Key? key, required this.editBudget, required this.isSelectedBudget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Изменить')),
      body: ChangeNotifierProvider(
        create: (context) =>
            ModelScreenNewEditBudget.edit(editBudget, isSelectedBudget),
        child: Consumer<ModelScreenNewEditBudget>(
          builder: (context, model, _) {
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                ButtonsDateTime(
                  dateTime: model.dateTime,
                  timeOfDay: model.timeOfDay,
                  onChangedDate: model.onChangedDate,
                  onChangedTime: model.onChangedTime,
                ),
                const Divider(),
                ButtonSelectCategory(
                  name: model.nameButCat,
                  onPressed: () =>
                      model.navigateScreenSelectionCategory(context),
                ),
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
                  nameButton: 'Изменить',
                  icons: Icons.create,
                  onPressed: () => model.onPressedButtonUpdateBudget(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
