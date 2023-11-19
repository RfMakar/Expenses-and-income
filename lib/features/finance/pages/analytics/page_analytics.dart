import 'package:budget/features/finance/pages/analytics/model_page_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аналитика'),
      ),
      body: ListView(
        children: const [
          WidgetButtonSwitchYear(),
          WidgetTableFromMonth(),
        ],
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

class WidgetTableFromMonth extends StatelessWidget {
  const WidgetTableFromMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetTextTitleTable(
          text: 'По месяцам:',
        )
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
/*
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
      child: Consumer<ModelPageAnalytics>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Аналитика'),
            ),
            body: FutureBuilder(
              future: provider.getListAnalitics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return provider.listAnalitics.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: provider.listAnalitics.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                provider.year(index).toString(),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              WidgetTableAnaliticsMonth(index: index),
                              WidgetTableAnaliticsAVGMonthExp(index: index),
                              WidgetTableAnaliticsAVGMonthInc(index: index),
                            ],
                          );
                        },
                      )
                    : const Center(child: Text('Данных пока нет'));
              },
            ),
          );
        },
      ),
    );
  }
}


class WidgetTableAnaliticsMonth extends StatelessWidget {
  const WidgetTableAnaliticsMonth({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    final provider = Provider.of<ModelPageAnalytics>(context);
    final listTableRow = provider
        .getListAnaliticsMonth(index)
        .map(
          (analiticsMonth) => TableRow(
            children: [
              WidgetTextRowTable(
                text: localeApp.dateMonth(
                    DateTime(provider.year(index), analiticsMonth.month)),
                //text: analiticsMonth.getMonth(provider.year(index)),
              ),
              WidgetTextRowTable(text: analiticsMonth.getExpence()),
              WidgetTextRowTable(text: analiticsMonth.getIncome()),
              WidgetTextRowTable(text: analiticsMonth.getTotal()),
            ],
          ),
        )
        .toList();
    listTableRow.insert(
      0,
      const TableRow(
        children: [
          WidgetTextColumnTable(text: 'Месяц'),
          WidgetTextColumnTable(text: 'Расход'),
          WidgetTextColumnTable(text: 'Доход'),
          WidgetTextColumnTable(text: 'Итого'),
        ],
      ),
    );
    listTableRow.add(
      TableRow(
        children: [
          const WidgetTextColumnTable(text: 'Итого'),
          WidgetTextColumnTable(text: provider.totalExpencec(index)),
          WidgetTextColumnTable(text: provider.totalIncome(index)),
          WidgetTextColumnTable(text: provider.totalTotal(index)),
        ],
      ),
    );

    return Column(
      children: [
        WidgetTextTitleTable(text: provider.titleTableMonth(index)),
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

class WidgetTableAnaliticsAVGMonthExp extends StatelessWidget {
  const WidgetTableAnaliticsAVGMonthExp({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ModelPageAnalytics>(context);
    final listTableRow = provider
        .getListAnaliticsAVGMonthExp(index)
        .map(
          (analiticsAVGMonth) => TableRow(
            children: [
              WidgetTextRowTable(
                text: analiticsAVGMonth.namecategory,
              ),
              WidgetTextRowTable(
                text: analiticsAVGMonth.getAVGCategory(),
              ),
            ],
          ),
        )
        .toList();
    listTableRow.insert(
      0,
      const TableRow(
        children: [
          WidgetTextColumnTable(text: 'Категория'),
          WidgetTextColumnTable(text: 'Среднее'),
        ],
      ),
    );

    return Column(
      children: [
        WidgetTextTitleTable(text: provider.titleTableAVGMonthExp(index)),
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

class WidgetTableAnaliticsAVGMonthInc extends StatelessWidget {
  const WidgetTableAnaliticsAVGMonthInc({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ModelPageAnalytics>(context);
    final listTableRow = provider
        .getListAnaliticsAVGMonthInc(index)
        .map(
          (analiticsAVGMonth) => TableRow(
            children: [
              WidgetTextRowTable(
                text: analiticsAVGMonth.namecategory,
              ),
              WidgetTextRowTable(
                text: analiticsAVGMonth.getAVGCategory(),
              ),
            ],
          ),
        )
        .toList();
    listTableRow.insert(
      0,
      const TableRow(
        children: [
          WidgetTextColumnTable(text: 'Категория'),
          WidgetTextColumnTable(text: 'Среднее'),
        ],
      ),
    );

    return Column(
      children: [
        WidgetTextTitleTable(text: provider.titleTableAVGMonthInc(index)),
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

*/