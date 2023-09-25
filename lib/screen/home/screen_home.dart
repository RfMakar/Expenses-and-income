import 'package:budget/screen/add_finance/screen_add_finance.dart';
import 'package:budget/screen/home/provider_screen_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      builder: (context, child) => Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
            floatingActionButton: provider.selectedIndex == 0
                ? FloatingActionButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenAddFinance(),
                        ),
                      );
                      provider.updateScreen();
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
            appBar: AppBar(
              title: Text(provider.titleAppBar()),
            ),
            drawer: const WidgetDrawer(),
            body: provider.screen(),
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
            leading: const Icon(Icons.home_outlined),
            title: const Text('Финансы'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.query_stats_outlined),
            title: const Text('Аналитика'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: const Text('Данные'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Настройки'),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(3);
            },
          ),
          const Center(child: Text('О приложении')),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.app_shortcut_outlined),
            title: Text('Версия'),
            subtitle: Text('1.0.6'),
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
