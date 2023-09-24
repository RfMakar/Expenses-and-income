import 'package:budget/screen/data_app/provider_screen_data_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDataApp extends StatelessWidget {
  const ScreenDataApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenDataApp(),
      builder: (context, child) => Consumer<ProviderScreenDataApp>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Данные'),
            ),
            body: ListView(),
          );
        },
      ),
    );
  }
}
