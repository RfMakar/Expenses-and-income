import 'package:budget/screens/app_finance/analytics/screen_analytics.dart';
import 'package:budget/screens/app_finance/data_app/screen_data_app.dart';
import 'package:budget/sheets/app_finance/menu_finance/provider_sheet_menu_finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetMenuFinance extends StatelessWidget {
  const SheetMenuFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderSheetMenuFinance(),
      child: Consumer<ProviderSheetMenuFinance>(
        builder: (context, provider, child) {
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
                      builder: (context) => const ScreenDataApp(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
