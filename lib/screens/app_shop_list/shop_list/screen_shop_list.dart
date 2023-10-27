import 'package:budget/dialogs/app_shop_list/add_shop_list/dialog_add_shop_list.dart';
import 'package:budget/screens/app_shop_list/shop_list/provider_screen_shop_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenShopList extends StatelessWidget {
  const ScreenShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenShopList(),
      child: Consumer<ProviderScreenShopList>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: Future(() => null),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 50),
                    children: [],
                  ),
                  const ButtonAddShoppList(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ButtonAddShoppList extends StatelessWidget {
  const ButtonAddShoppList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenShopList>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () async {
          bool result = await showDialog(
            context: context,
            builder: (context) => const DialogAddShopList(),
          );
          if (result) {
            provider.updateScreen();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
