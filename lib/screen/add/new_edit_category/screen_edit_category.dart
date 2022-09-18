import 'package:budget/screen/add/new_edit_category/model_screen_edit_categoty.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/widget/buttons_add_edit_category.dart';
import 'package:budget/screen/widget/button_select_color.dart';
import 'package:budget/screen/widget/textfield_category.dart';
import 'package:provider/provider.dart';

class ScreenEditCategory extends StatelessWidget {
  const ScreenEditCategory(
      {Key? key, required this.category, required this.isSelectedBudget})
      : super(key: key);
  final Category category;
  final List<bool> isSelectedBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Изменить категорию')),
      body: ChangeNotifierProvider(
        create: (context) =>
            ModelScreenEditCategory(category, isSelectedBudget),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Builder(builder: (context) {
              var model = context.read<ModelScreenEditCategory>();
              var valid = context.select(
                  (ModelScreenEditCategory model) => model.validateTextField);
              return TextFieldCategory(
                textController: model.textController,
                validate: valid,
              );
            }),
            const Divider(),
            Builder(builder: (context) {
              var model = context.read<ModelScreenEditCategory>();
              var colorIcon = context
                  .select((ModelScreenEditCategory model) => model.colorIcon);
              return ButtonSelectColor(
                colorIcon: colorIcon,
                onPressed: model.onPressedButtonSelectColor,
              );
            }),
            const Divider(),
            Builder(builder: (context) {
              var model = context.read<ModelScreenEditCategory>();
              return ButtonAddEditCategory(
                nameButton: 'Изменить',
                icons: Icons.create,
                onPressed: () => model.onPressedButtonCreateCategory(context),
              );
            })
          ],
        ),
      ),
    );
  }
}
