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
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Center(
                        child: Text(provider.titleTable(index)),
                      )
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
