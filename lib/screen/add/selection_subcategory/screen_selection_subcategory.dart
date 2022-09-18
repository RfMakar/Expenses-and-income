import 'package:budget/screen/add/new_edit_subcategory/screen_new_subcategory.dart';
import 'package:budget/screen/widget/bottom_sheet_del_edit.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/category.dart';
import 'package:budget/screen/add/selection_subcategory/model_selection_subcategory.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenSelectionSubcategory extends StatelessWidget {
  const ScreenSelectionSubcategory(
      {Key? key, required this.category, required this.isSelectedBudget})
      : super(key: key);
  final Category category;
  final List<bool> isSelectedBudget;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ModelScreenSeletionSubcategory(category, isSelectedBudget),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenNewSubcategory(
                            category: category,
                            isSelectedBudget: isSelectedBudget,
                          )),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const SubCategoryListWidget(),
      ),
    );
  }
}

class SubCategoryListWidget extends StatelessWidget {
  const SubCategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<ModelScreenSeletionSubcategory>();
    return FutureBuilder<List<Category>>(
      future: model.subcategoryList(),
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
              title: Text(category.subname!),
              onTap: () => Navigator.pop(context, category),
              onLongPress: () => onLongPressListTile(
                context,
                () => model.onLongPressListTileDelete(context, category),
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
