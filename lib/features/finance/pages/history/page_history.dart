import 'package:budget/features/app/pages/material_app/model_material_app.dart';
import 'package:budget/features/finance/pages/history/model_page_history.dart';
import 'package:budget/features/finance/widgets/history_operations/widget_history_operations.dart';
import 'package:budget/features/finance/widgets/no_data.dart';
import 'package:budget/repositories/finance/models/operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageHistory extends StatelessWidget {
  const PageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final modelApp = Provider.of<ModelMaterialApp>(context);
    return ChangeNotifierProvider(
      create: (context) => ModelPageHistory(modelApp.finance),
      child: const PageView(),
    );
  }
}

class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localeApp.historyOfOperations),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: const [
          WidgetSwitchFinance(),
          WidgetButtonSwitchMonth(),
          WidgetHistory(),
        ],
      ),
    );
  }
}

class WidgetSwitchFinance extends StatelessWidget {
  const WidgetSwitchFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final modelApp = context.watch<ModelMaterialApp>();
    final model = context.watch<ModelPageHistory>();
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
          Center(child: Text(localeApp.expense)),
          Center(child: Text(localeApp.income)),
        ],
      ),
    );
  }
}

class WidgetButtonSwitchMonth extends StatelessWidget {
  const WidgetButtonSwitchMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.watch<ModelPageHistory>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.grey,
          icon: const Icon(Icons.navigate_before),
          onPressed: model.onPressedButSwitchDateBack,
        ),
        Text(
          localeApp.dateFormatPeriodMonth(model.dateTime),
          style: const TextStyle(color: Colors.grey),
        ),
        IconButton(
          color: Colors.grey,
          onPressed: model.onPressedButSwitchDateNext,
          icon: const Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}

class WidgetHistory extends StatelessWidget {
  const WidgetHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ModelPageHistory>();
    return FutureBuilder<List<HistoryOperation>>(
      future: model.getListHistoryOperationByMonth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }
        final listHistoryOperations = snapshot.data!;
        return listHistoryOperations.isEmpty
            ? const WidgetNoData()
            : WidgetHistoryOperations(
                listHistoryOperation: listHistoryOperations,
                updateScreen: model.updatePage,
              );
      },
    );
  }
}
