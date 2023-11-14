import 'package:budget/const/actions_update.dart';
import 'package:budget/features/finanse/pages/category/model_page_category.dart';
import 'package:budget/features/finanse/pages/subcategory/page_subcategory.dart';
import 'package:budget/features/finanse/sheets/select_period/sheet_select_period.dart';
import 'package:budget/features/finanse/widgets/group_categories.dart';
import 'package:budget/features/finanse/widgets/history/widget_history.dart';
import 'package:budget/features/finanse/widgets/no_data.dart';
import 'package:budget/model_app.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageCategory extends StatelessWidget {
  const PageCategory({super.key, required this.groupCategory});

  final GroupCategory groupCategory;

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ModelApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ModelPageCategory(
          providerApp.finance, providerApp.switchDate, groupCategory),
      child: const ViewPage(),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelPageCategory>();
    return Scaffold(
      appBar: AppBar(
        title: Text(model.titleAppBar()),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
        children: const [
          WidgetInfo(),
          WidgetListGroupSubCategory(),
          WidHistory(),
        ],
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelPageCategory>();
    final providerApp = context.read<ModelApp>();
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Builder(builder: (context) {
            final model = context.watch<ModelPageCategory>();
            return FutureBuilder(
              future: model.getSumOperationCategory(),
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
                    final model = context.watch<ModelPageCategory>();
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

class WidgetListGroupSubCategory extends StatelessWidget {
  const WidgetListGroupSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelPageCategory>();
    return FutureBuilder(
      future: model.getListGroupSubCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: Container());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return model.listGroupSubCategory.isEmpty
            ? Container()
            : Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Подкатегории',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.listGroupSubCategory.length,
                    itemBuilder: (context, index) {
                      return WidgetGroupCategories(
                        name: model.titleGroupSubCategory(index),
                        value: model.valueGroupSubCategory(index),
                        percent: model.percentGroupSubCategory(index),
                        color: model.colorGroupSubCategory(index),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageSubCategory(
                                groupSubCategory: model.groupSubCategory(index),
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

class WidHistory extends StatelessWidget {
  const WidHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelPageCategory>();
    return FutureBuilder(
      future: model.getListHistoryOperationCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: Container());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return model.listHistoryOperation.isEmpty
            ? const WidgetNoData()
            : WidgetHistory(
                listHistoryOperation: model.listHistoryOperation,
                updateScreen: model.updatePage,
              );
      },
    );
  }
}
