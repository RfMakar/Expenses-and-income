import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/finance/pages/subcategory/model_page_subcategory.dart';
import 'package:budget/features/finance/sheets/select_period/sheet_select_period.dart';
import 'package:budget/features/finance/widgets/history_operations/widget_history_operations.dart';
import 'package:budget/features/finance/widgets/no_data.dart';
import 'package:budget/repositories/finance/models/subcategories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageSubCategory extends StatelessWidget {
  const PageSubCategory({super.key, required this.groupSubCategory});
  final GroupSubCategory groupSubCategory;

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ModelMaterialApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ModelPageSubCategory(
          providerApp.finance, providerApp.switchDate, groupSubCategory),
      child: const ViewPage(),
    );
  }
}

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelPageSubCategory>();
    return Scaffold(
      appBar: AppBar(
        title: Text(model.titleAppBar()),
      ),
      body: ListView(
        children: const [
          WidgetInfo(),
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
    final localeApp = AppLocalizations.of(context)!;
    final model = context.read<ModelPageSubCategory>();
    final modelApp = context.read<ModelMaterialApp>();
    return Card(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Builder(builder: (context) {
            final model = context.watch<ModelPageSubCategory>();
            return FutureBuilder(
              future: model.getSumOperationSubCategory(),
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
                  localeApp
                      .valueFormatSimpleCurrency(model.titleSumOperation()),
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
                      modelApp.switchDate.backDate();
                      model.updatePage();
                    },
                  ),
                  Consumer<ModelPageSubCategory>(
                    builder: (context, value, child) {
                      String titleDateTime() {
                        switch (modelApp.switchDate.state) {
                          case 0:
                            return localeApp.dateFormatPeriodMonth(
                                modelApp.switchDate.getDateTime());
                          case 1:
                            return localeApp.dateFormatPeriodYear(
                                modelApp.switchDate.getDateTime());
                          default:
                            return '';
                        }
                      }

                      return Text(
                        titleDateTime(),
                        style: const TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {
                      modelApp.switchDate.nextDate();
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

class WidHistory extends StatelessWidget {
  const WidHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.watch<ModelPageSubCategory>();
    return FutureBuilder(
      future: model.getListHistoryOperationSubCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: Container());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        return model.listHistoryOperation.isEmpty
            ? const WidgetNoData()
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    localeApp.operationsHistory,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  WidgetHistoryOperations(
                    listHistoryOperation: model.listHistoryOperation,
                    updateScreen: model.updatePage,
                  ),
                ],
              );
      },
    );
  }
}
