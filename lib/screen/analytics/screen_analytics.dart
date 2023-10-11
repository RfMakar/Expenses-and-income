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
              return ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  const Center(
                    child: Text(
                      '2023',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.yellow,
                        width: 2,
                        borderRadius: BorderRadius.circular(4)),
                    children: const [
                      TableRow(
                        children: [
                          Center(child: Text('Месяц')),
                          Center(child: Text('Расход')),
                          Center(child: Text('Доход')),
                          Center(child: Text('Итого')),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(child: Text('Итого')),
                          Center(child: Text('-333333')),
                          Center(child: Text('+3333')),
                          Center(child: Text('-200цуцу0')),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class WidgetTable extends StatelessWidget {
  const WidgetTable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
