import 'package:flutter/material.dart';
import 'package:budget/screen/add/new_edit_category/model_screen_new_category.dart';
import 'package:budget/screen/widget/buttons_add_edit_category.dart';
import 'package:budget/screen/widget/button_select_color.dart';
import 'package:budget/screen/widget/textfield_category.dart';
import 'package:provider/provider.dart';

class ScreenNewCategory extends StatelessWidget {
  const ScreenNewCategory({Key? key, required this.isSelectedBudget})
      : super(key: key);
  final List<bool> isSelectedBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая категория'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ModelScreenNewCategory(isSelectedBudget),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Builder(builder: (context) {
              var model = context.read<ModelScreenNewCategory>();
              var valid = context.select(
                  (ModelScreenNewCategory model) => model.validateTextField);
              return TextFieldCategory(
                textController: model.textController,
                validate: valid,
              );
            }),
            const Divider(),
            Builder(builder: (context) {
              var model = context.read<ModelScreenNewCategory>();
              var colorIcon = context
                  .select((ModelScreenNewCategory model) => model.colorIcon);
              return ButtonSelectColor(
                colorIcon: colorIcon,
                onPressed: model.onPressedButtonSelectColor,
              );
            }),
            const Divider(),
            Builder(builder: (context) {
              var model = context.read<ModelScreenNewCategory>();
              return ButtonAddEditCategory(
                nameButton: 'Добавить',
                icons: Icons.add,
                onPressed: () => model.onPressedButtonAddCategory(context),
              );
            }),
          ],
        ),
      ),
    );
  }
}
