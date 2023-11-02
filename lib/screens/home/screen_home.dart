import 'package:budget/screens/home/provider_screen_home.dart';
import 'package:budget/sheets/app_finance/menu_finance/sheet_menu_finance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      child: Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(provider.titleAppBar()),
              actions: provider.selectedIndex == 0
                  ? [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const SheetMenuFinance(),
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ]
                  : null,
            ),
            drawer: const WidgetDrawer(),
            body: provider.widgetScreen(),
          );
        },
      ),
    );
  }
}

class WidgetDrawer extends StatelessWidget {
  const WidgetDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenHome>(context);
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(child: Text('Навигация')),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: const Text('Финансы'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('Списки'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(1);
            },
          ),
          const Center(child: Text('О приложении')),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.app_shortcut_outlined),
            title: Text('Версия'),
            subtitle: Text('1.0.12'),
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Политика конфиденциальности'),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://sites.google.com/view/ideamight/budget/privacypolicy');

              if (!await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.grade_outlined, color: Colors.yellow),
            title: const Text('Оставить отзыв'),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://play.google.com/store/apps/details?id=ru.ideamight.budget');

              if (!await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              )) {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
