import 'package:budget/const/actions_update.dart';
import 'package:budget/features/finanse/pages/add_finance/screen_add_finance.dart';
import 'package:budget/features/finanse/pages/category/screen_category.dart';
import 'package:budget/features/finanse/pages/finance/provider_screen_finance.dart';
import 'package:budget/features/finanse/sheets/select_period/sheet_select_period.dart';
import 'package:budget/features/finanse/widgets/group_categories.dart';
import 'package:budget/features/finanse/widgets/no_data.dart';
import 'package:budget/features/finanse/widgets/switch_date.dart';
import 'package:budget/features/finanse/widgets/switch_finance.dart';
import 'package:budget/provider_app.dart';
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
    final providerApp = Provider.of<ProviderApp>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenAddFinance(),
            ),
          );
          provider.updateScreen();
        },
        label: Text(providerApp.finance.titleFinance()),
        icon: const Icon(Icons.add),
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
        if (update == StateUpdate.page) {
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
