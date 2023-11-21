import 'package:budget/features/finance/pages/analytics/page_analytics.dart';
import 'package:budget/features/finance/pages/data_app/page_data_app.dart';
import 'package:budget/features/finance/pages/history/page_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SheetMenuFinance extends StatelessWidget {
  const SheetMenuFinance({super.key});

  @override
  Widget build(BuildContext context) {
    final localeApp = AppLocalizations.of(context)!;
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.history_outlined),
          title: Text(localeApp.operationsHistory),
          onTap: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageHistory(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.query_stats_outlined),
          title: Text(localeApp.analytics),
          onTap: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageAnalytics(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.cloud_outlined),
          title: Text(localeApp.data),
          onTap: () {
            // Navigator.pop(context);
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
