import 'package:budget/const/actions_update.dart';
import 'package:budget/provider_app.dart';
import 'package:budget/repositories/finanse/models/subcategories.dart';
import 'package:budget/screens/app_finance/subcategory/provider_screen_subcategory.dart';
import 'package:budget/sheets/app_finance/select_period/sheet_select_period.dart';
import 'package:budget/widget/history/widget_history.dart';
import 'package:budget/widget/no_data.dart';
import 'package:budget/widget/switch_date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSubCategory extends StatelessWidget {
  const ScreenSubCategory({super.key, required this.groupSubCategory});

  final GroupSubCategory groupSubCategory;
  @override
  Widget build(BuildContext context) {
    final providerApp = Provider.of<ProviderApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenSubCategory(
          providerApp.finance.id, providerApp.switchDate, groupSubCategory),
      child: Consumer<ProviderScreenSubCategory>(
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
                  provider.listHistoryOperation.isEmpty
                      ? const WidgetNoData()
                      : WidgetHistory(
                          listHistoryOperation: provider.listHistoryOperation,
                          updateScreen: provider.updateScreen,
                        ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

class WidgetInfo extends StatelessWidget {
  const WidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenSubCategory>(context);
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
