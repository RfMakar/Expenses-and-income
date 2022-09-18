import 'package:budget/screen/widget/bottom_sheet_del_edit.dart';
import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/home/history/model_history.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({
    Key? key,
    required this.nameCategory,
    required this.dateTime,
    required this.isSelected,
    required this.isSelectedBudget,
  }) : super(key: key);
  final DateTime dateTime;
  final List<bool> isSelected;
  final String nameCategory;
  final List<bool> isSelectedBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nameCategory)),
      body: ChangeNotifierProvider(
        create: (context) => ModelScreenHistory(
          dateTime: dateTime,
          isSelected: isSelected,
          nameCategory: nameCategory,
          isSelectedBudget: isSelectedBudget,
        ),
        child: Consumer<ModelScreenHistory>(
          builder: (context, model, _) => FutureBuilder<List<Budget>>(
            future: model.historyListExpenses(nameCategory),
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
                  Budget budget = snapshot.data![index];

                  return ListTile(
                    leading: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(budget.getFormatDateDayMonth()),
                        Text(budget.getFormatTimeHourMinute()),
                      ],
                    ),
                    title: budget.subcategory == null
                        ? null
                        : Text(budget.subcategory!),
                    subtitle:
                        budget.comment == null ? null : Text(budget.comment!),
                    trailing: Text(budget.getFormatSumExpenses()),
                    onLongPress: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => BottomSheetDelEdit(
                        onTapDelete: () =>
                            model.onLongPressListTileDelete(context, budget),
                        onTapEdit: () =>
                            model.onLongPressListTileEdit(context, budget),
                      ),
                    ),
                    shape: MyWidget.widgetShapeBorderListTile(budget.color!),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
