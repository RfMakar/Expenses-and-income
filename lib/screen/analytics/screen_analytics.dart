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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Аналитика'),
            ),
            body: ListView(),
          );
        },
      ),
    );
  }
}
