import 'package:flutter/material.dart';
import 'package:budget/model/budget.dart';
import 'package:budget/screen/home/model_home.dart';
import 'package:budget/screen/widget/buttons_expenses_income.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelScreenHome(),
      child: Stack(
        children: const [
          GroupListWidget(),
          InfoWidget(),
        ],
      ),
    );
  }
}

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelScreenHome>(builder: (context, model, _) {
      return FutureBuilder<List<Budget>>(
        future: model.groupListBudget(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MyWidget.widgetLoading();
          }
          if (snapshot.data!.isEmpty) {
            return MyWidget.widgetIsEmpty();
          }
          return ListView.separated(
            padding:
                const EdgeInsets.only(top: 140, left: 8, right: 8, bottom: 8),
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              Budget budget = snapshot.data![index];

              return ListTile(
                title: Text(budget.category!),
                subtitle: Text('Количество записей: ${budget.number} шт'),
                trailing: Text(budget.getFormatSumExpenses()),
                shape: MyWidget.widgetShapeBorderListTile(budget.color!),
                onTap: () => model.onTapListTile(context, budget),
              );
            },
          );
        },
      );
    });
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelScreenHome>(
      builder: (context, model, _) => Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          child: Wrap(
            children: [
              toggleButtonsDayMonthYear(model, context),
              sumBudget(model, context),
              ButtonsExpensesIncome(
                isSelected: model.isSelectedBudget,
                onPressed: model.onPressedButExpensesIncome,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleButtonsDayMonthYear(
      ModelScreenHome model, BuildContext context) {
    final widthToggle = MediaQuery.of(context).size.width * (0.7 / 3.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          splashRadius: 10,
          onPressed: model.onPressedButtonDateBack,
          icon: const Icon(Icons.navigate_before),
        ),
        ToggleButtons(
          constraints: BoxConstraints(minHeight: 30, minWidth: widthToggle),
          isSelected: model.isSelectedDate,
          onPressed: (index) => model.onPressedToggleButtons(index),
          children: [
            Center(child: Text(model.getDay())),
            Center(child: Text(model.getMonth())),
            Center(child: Text(model.getYear())),
          ],
        ),
        IconButton(
          splashRadius: 10,
          onPressed: model.onPressedButtonDateNext,
          icon: const Icon(Icons.navigate_next),
        ),
      ],
    );
  }

  Widget sumBudget(ModelScreenHome model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<String>(
          future: model.getSumTextFormat(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return MyWidget.widgetLoading();
            }
            if (snapshot.data!.isEmpty) {
              return MyWidget.widgetIsEmpty();
            }
            return Text(snapshot.data!, style: const TextStyle(fontSize: 25));
          },
        ),
      ],
    );
  }
}
