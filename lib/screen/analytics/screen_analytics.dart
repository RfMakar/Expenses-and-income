import 'package:budget/screen/analytics/provider_screen_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAnalytics extends StatelessWidget {
  const ScreenAnalytics({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenAnalytics(),
      builder: (context, child) => Consumer<ProviderScreenAnalytics>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.getListYear(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: provider.listAnalitics.length,
                itemBuilder: (context, index) {
                  final listTableRow = provider
                      .getListAnaliticsMonth(index)
                      .map(
                        (analiticsMonth) => TableRow(
                          children: [
                            WidgetTextRowTable(
                              text:
                                  analiticsMonth.getMonth(provider.year(index)),
                            ),
                            WidgetTextRowTable(
                                text: analiticsMonth.getExpence()),
                            WidgetTextRowTable(
                                text: analiticsMonth.getIncome()),
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
                        WidgetTextColumnTable(
                            text: provider.totalExpencec(index)),
                        WidgetTextColumnTable(
                            text: provider.totalIncome(index)),
                        WidgetTextColumnTable(text: provider.totalTotal(index)),
                      ],
                    ),
                  );
                  return Column(
                    children: [
                      WidgetTextTitleTable(text: provider.titleTable(index)),
                      Table(
                        border: TableBorder.all(
                            color: Colors.yellow,
                            width: 1,
                            borderRadius: BorderRadius.circular(4)),
                        children: listTableRow,
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class WidgetTextRowTable extends StatelessWidget {
  const WidgetTextRowTable({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: const TextStyle(fontSize: 11),
    ));
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
      child: Center(
          child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
