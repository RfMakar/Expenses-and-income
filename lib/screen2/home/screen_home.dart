import 'package:budget/screen2/add_category/screen_add_categoty.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      builder: (context, child) => Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenAddCategory(
                      isSelectedBudget: provider.isSelectedBudget,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: const Text('budget'),
            ),
          );
        },
      ),
    );
  }
}
