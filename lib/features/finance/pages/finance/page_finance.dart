import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/finance/pages/add_finance/page_add_finance.dart';
import 'package:budget/features/finance/pages/category/page_category.dart';
import 'package:budget/features/finance/pages/finance/model_page_finance.dart';
import 'package:budget/features/finance/sheets/select_period/sheet_select_period.dart';
import 'package:budget/features/finance/widgets/group_categories.dart';
import 'package:budget/features/finance/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageFinance extends StatelessWidget {
  const PageFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = context.read<ModelMaterialApp>();
    return ChangeNotifierProvider(
      create: (context) =>
          ModelPageFinance(providerApp.finance, providerApp.switchDate),
      child: const ViewPage(),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 50),
          children: const [
            WidgetSwitchFinance(),
            WidgetInfo(),
            WidgetListGroupCategory(),
          ],
        ),
        const ButtonAddFinance(),
      ],
    );
  }
}

class WidgetSwitchFinance extends StatelessWidget {
  const WidgetSwitchFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = context.watch<ModelMaterialApp>();
    final model = context.watch<ModelPageFinance>();
    final widthToggle = MediaQuery.of(context).size.width * (0.8 / 2.0);
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(maxHeight: 30, minWidth: widthToggle),
        isSelected: modelApp.finance.isSelected,
        onPressed: (index) {
          modelApp.finance.onPressed(index);
          model.updatePage();
        },
        children: [
          Center(child: Text(modelApp.finance.expense)),
          Center(child: Text(modelApp.finance.income)),
        ],
      ),
    );
  }
}

class ButtonAddFinance extends StatelessWidget {
  const ButtonAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = context.watch<ModelMaterialApp>();
    final model = context.watch<ModelPageFinance>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PageAddFinance(),
            ),
          );
          model.updatePage();
        },
        label: Text(modelApp.finance.titleFinance()),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelPageFinance>();
    final providerApp = context.read<ModelMaterialApp>();
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Builder(builder: (context) {
            final model = context.watch<ModelPageFinance>();
            return FutureBuilder(
              future: model.getSumAllOperation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                      child: Text(
                    '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ));
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Text(
                  model.titleSumOperation(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 40,
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () {
                      providerApp.switchDate.backDate();
                      model.updatePage();
                    },
                  ),
                  Builder(builder: (context) {
                    final model = context.watch<ModelPageFinance>();
                    return Text(
                      model.titleDateTime(),
                      style: const TextStyle(color: Colors.grey),
                    );
                  }),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {
                      providerApp.switchDate.nextDate();
                      model.updatePage();
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final update = await showModalBottomSheet(
                    context: context,
                    builder: (context) => const SheetSelectPeriod(),
                  );
                  if (update == StateUpdate.page) {
                    model.updatePage();
                  }
                },
                icon: const Icon(Icons.date_range_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetListGroupCategory extends StatelessWidget {
  const WidgetListGroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelPageFinance>();
    return FutureBuilder(
      future: model.getListGroupCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: Container());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return model.listGroupCategory.isEmpty
            ? const WidgetNoData()
            : Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Категории',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.listGroupCategory.length,
                    itemBuilder: (context, index) {
                      return WidgetGroupCategories(
                        color: model.colorGroupCategory(index),
                        name: model.titleGroupCategory(index),
                        percent: model.percentGroupCategory(index),
                        value: model.valueGroupCategory(index),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageCategory(
                                groupCategory: model.groupCategory(index),
                              ),
                            ),
                          );
                          model.updatePage();
                        },
                      );
                    },
                  ),
                ],
              );
      },
    );
  }
}
