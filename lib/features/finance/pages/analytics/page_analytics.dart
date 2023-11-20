import 'package:budget/features/finance/pages/analytics/model_page_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageAnalytics extends StatelessWidget {
  const PageAnalytics({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelPageAnalytics(),
      child: const PageView(),
    );
  }
}

class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.watch<ModelPageAnalytics>();
    return Scaffold(
      appBar: AppBar(
        title: Text(localeApp.analytics),
      ),
      body: FutureBuilder(
        future: model.load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: Container());
          }
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(4),
            children: const [
              WidgetButtonSwitchYear(),
              WidgetTableByMonth(),
            ],
          );
        },
      ),
    );
  }
}

class WidgetButtonSwitchYear extends StatelessWidget {
  const WidgetButtonSwitchYear({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final model = context.watch<ModelPageAnalytics>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.grey,
          icon: const Icon(Icons.navigate_before),
          onPressed: model.onPressedButSwitchDateBack,
        ),
        Text(
          localeApp.dateFormatPeriodYear(model.dateTime),
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

class WidgetTableByMonth extends StatelessWidget {
  const WidgetTableByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ModelPageAnalytics>();
    final localeApp = AppLocalizations.of(context)!;
    final listTableRow = model.listAnaliticsByMonth
        .map(
          (analiticsMonth) => TableRow(
            children: [
              WidgetTextRowTable(
                text: localeApp.dateMonth(
                    DateTime(model.dateTime.year, analiticsMonth.month)),
                //text: analiticsMonth.getMonth(provider.year(index)),
              ),
              WidgetTextRowTable(
                text: localeApp.valueFormatCompact(analiticsMonth.expense),
              ),
              WidgetTextRowTable(
                text: localeApp.valueFormatCompact(analiticsMonth.income),
              ),
              WidgetTextRowTable(
                text: localeApp.valueFormatCompact(analiticsMonth.total),
              ),
            ],
          ),
        )
        .toList();
    listTableRow.insert(
      0,
      TableRow(
        children: [
          WidgetTextColumnTable(text: localeApp.month),
          WidgetTextColumnTable(text: localeApp.expense),
          WidgetTextColumnTable(text: localeApp.income),
          WidgetTextColumnTable(text: localeApp.total),
        ],
      ),
    );
    listTableRow.add(
      TableRow(
        children: [
          WidgetTextColumnTable(text: localeApp.total),
          WidgetTextColumnTable(
            text: localeApp.valueFormatCompact(model.totalExpencec()),
          ),
          WidgetTextColumnTable(
            text: localeApp.valueFormatCompact(model.totalIncome()),
          ),
          WidgetTextColumnTable(
            text: localeApp.valueFormatCompact(model.totalTotal()),
          ),
        ],
      ),
    );
    return Column(
      children: [
        WidgetTextTitleTable(text: localeApp.byMonth),
        Table(
          border: TableBorder.all(
              color: Colors.grey,
              width: 1,
              borderRadius: BorderRadius.circular(4)),
          children: listTableRow,
        ),
      ],
    );
  }
}

class WidgetTextRowTable extends StatelessWidget {
  const WidgetTextRowTable({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}

class WidgetTextColumnTable extends StatelessWidget {
  const WidgetTextColumnTable({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ));
  }
}

class WidgetTextTitleTable extends StatelessWidget {
  const WidgetTextTitleTable({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
