import 'package:budget/screen/analytics/screen_analytics.dart';
import 'package:budget/screen/data_app/screen_data_app.dart';
import 'package:budget/screen/settings/screen_settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetDrawer extends StatelessWidget {
  const WidgetDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        const Center(child: Text('Меню')),
        const Divider(),
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
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Настройки'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenSettings(),
              ),
            );
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
    );
  }
}
