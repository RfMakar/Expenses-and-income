import 'package:budget/features/finanse/pages/analytics/screen_analytics.dart';
import 'package:budget/features/finanse/pages/data_app/page_data_app.dart';
import 'package:flutter/material.dart';

class SheetMenuFinance extends StatelessWidget {
  const SheetMenuFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.query_stats_outlined),
          title: const Text('Аналитика'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenAnalytics(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.cloud_outlined),
          title: const Text('Данные'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageDataApp(),
              ),
            );
          },
        ),
      ],
    );
  }
}
