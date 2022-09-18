import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/add/new_edit_subcategory/model_new_edit_subcategory.dart';
import 'package:budget/screen/widget/buttons_add_edit_category.dart';
import 'package:budget/screen/widget/textfield_category.dart';
import 'package:provider/provider.dart';

class ScreenNewSubcategory extends StatelessWidget {
  const ScreenNewSubcategory(
      {Key? key, required this.category, required this.isSelectedBudget})
      : super(key: key);
  final Category category;
  final List<bool> isSelectedBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая подкатегория'),
      ),
      body: ChangeNotifierProvider(
          create: (context) =>
              ModelScreenNewEditSubcategory(category, isSelectedBudget),
          child: Consumer<ModelScreenNewEditSubcategory>(
            builder: (context, model, _) {
              return ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  TextFieldCategory(
                    textController: model.textController,
                    validate: model.validateTextField,
                  ),
                  const Divider(),
                  ButtonAddEditCategory(
                    nameButton: 'Добавить',
                    icons: Icons.add,
                    onPressed: () =>
                        model.onPressedButtonAddSubcategory(context),
                  )
                ],
              );
            },
          )),
    );
  }
}
