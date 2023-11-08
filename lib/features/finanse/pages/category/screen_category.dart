import 'package:budget/const/actions_update.dart';
import 'package:budget/features/finanse/pages/category/provider_screen_category.dart';
import 'package:budget/features/finanse/pages/subcategory/screen_subcategory.dart';
import 'package:budget/features/finanse/sheets/select_period/sheet_select_period.dart';
import 'package:budget/features/finanse/widgets/group_categories.dart';
import 'package:budget/features/finanse/widgets/history/widget_history.dart';
import 'package:budget/features/finanse/widgets/no_data.dart';
import 'package:budget/features/finanse/widgets/switch_date.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/repositories/finance/models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key, required this.groupCategory});

  final GroupCategory groupCategory;

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenCategory(
          providerApp.finance.id, providerApp.switchDate, groupCategory),
      child: Consumer<ProviderScreenCategory>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(provider.titleAppBar()),
            ),
            body: FutureBuilder(
              future: provider.loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: [
                    const SizedBox(height: 4),
                    const WidgetInfo(),
                    provider.listGroupSubCategory.isEmpty
                        ? const WidgetNoData()
                        : const WidgetListGroupSubCategory(),
                    provider.listHistoryOperation.isEmpty
                        ? const SizedBox()
                        : WidgetHistory(
                            listHistoryOperation: provider.listHistoryOperation,
                            updateScreen: provider.updateScreen,
                          ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return WidgetSwitchDate(
      titleValue: provider.titleSumOperation(),
      onPressedButBackDate: provider.onPressedButBackDate,
      onPressedButNextDate: provider.onPressedButNextDate,
      onPressedButSelPeriod: () async {
        final update = await showModalBottomSheet(
          context: context,
          builder: (context) => const SheetSelectPeriod(),
        );
        if (update == StateUpdate.page) {
          provider.updateScreen();
        }
      },
    );
  }
}

class WidgetListGroupSubCategory extends StatelessWidget {
  const WidgetListGroupSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenCategory>(context);
    return Column(
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
          itemCount: provider.listGroupSubCategory.length,
          itemBuilder: (context, index) {
            return WidgetGroupCategories(
              name: provider.titleGroupSubCategory(index),
              value: provider.valueGroupSubCategory(index),
              percent: provider.percentGroupSubCategory(index),
              color: provider.colorGroupSubCategory(index),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenSubCategory(
                      groupSubCategory: provider.groupSubCategory(index),
                    ),
                  ),
                );
                provider.updateScreen();
              },
            );
          },
        ),
      ],
    );
  }
}
