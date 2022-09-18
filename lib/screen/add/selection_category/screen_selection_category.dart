import 'package:budget/screen/add/new_edit_category/screen_new_category.dart';
import 'package:budget/screen/widget/bottom_sheet_del_edit.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/add/selection_category/model_selection_category.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenSelectionCategory extends StatelessWidget {
  const ScreenSelectionCategory({Key? key, required this.isSelectedBudget})
      : super(key: key);
  final List<bool> isSelectedBudget;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelScreenSeletionCategory(isSelectedBudget),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Категории'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenNewCategory(
                          isSelectedBudget: isSelectedBudget)),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const CategoryListWidget(),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ModelScreenSeletionCategory>();
    return FutureBuilder<List<Category>>(
      future: model.categoryList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MyWidget.widgetLoading();
        }
        if (snapshot.data!.isEmpty) {
          return MyWidget.widgetIsEmpty();
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: snapshot.data!.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (context, index) {
            Category category = snapshot.data![index];

            return ListTile(
              title: Text(category.name),
              onTap: () => Navigator.pop(context, category),
              onLongPress: () => onLongPressListTile(
                context,
                () => model.onLongPressListTileDelete(category),
                () => model.onLongPressListTileEdit(context, category),
              ),
              shape: MyWidget.widgetShapeBorderListTile(category.color),
            );
          },
        );
      },
    );
  }

  void onLongPressListTile(BuildContext context, void Function() onTapDelete,
      void Function() onTapEdit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetDelEdit(
        onTapDelete: () {
          onTapDelete();
          Navigator.pop(context);
        },
        onTapEdit: () {
          onTapEdit();
        },
      ),
    );
  }
}
