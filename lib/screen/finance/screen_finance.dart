import 'package:budget/const/actions_update.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/screen/add_finance/screen_add_finance.dart';
import 'package:budget/screen/category/screen_category.dart';
import 'package:budget/screen/finance/provider_screen_finance.dart';
import 'package:budget/sheets/select_period/sheet_select_period.dart';
import 'package:budget/widget/group_categories.dart';
import 'package:budget/widget/no_data.dart';
import 'package:budget/widget/switch_date.dart';
import 'package:budget/widget/switch_finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFinance extends StatelessWidget {
  const ScreenFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenFinance(providerApp.switchDate),
      child: Consumer<ProviderScreenFinance>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.loadData(providerApp.finance.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 50),
                    children: [
                      const WidgetSwitchFinance(),
                      const WidgetInfo(),
                      provider.listGroupCategory.isEmpty
                          ? const WidgetNoData()
                          : const WidgetListGroupCategory(),
                    ],
                  ),
                  const ButtonAddFinance(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ButtonAddFinance extends StatelessWidget {
  const ButtonAddFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenAddFinance(),
            ),
          );
          provider.updateScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);

    return WidgetSwitchDate(
      titleValue: provider.titleSumOperation(),
      onPressedButBackDate: provider.onPressedButBackDate,
      onPressedButNextDate: provider.onPressedButNextDate,
      onPressedButSelPeriod: () async {
        final update = await showModalBottomSheet(
          context: context,
          builder: (context) => const SheetSelectPeriod(),
        );
        if (update == ActionsUpdate.updateScreen) {
          provider.updateScreen();
        }
      },
    );
  }
}

class WidgetListGroupCategory extends StatelessWidget {
  const WidgetListGroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenFinance>(context);
    return Column(
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
          itemCount: provider.listGroupCategory.length,
          itemBuilder: (context, index) {
            return WidgetGroupCategories(
              color: provider.colorGroupCategory(index),
              name: provider.titleGroupCategory(index),
              percent: provider.percentGroupCategory(index),
              value: provider.valueGroupCategory(index),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenCategory(
                      groupCategory: provider.groupCategory(index),
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
