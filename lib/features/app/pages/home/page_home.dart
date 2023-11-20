import 'package:budget/features/app/pages/home/model_page_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    String titleAppBar(int index) {
      final localeApp = AppLocalizations.of(context)!;
      switch (index) {
        case 0:
          return localeApp.finance;
        case 1:
          return localeApp.lists;
        default:
          return '';
      }
    }

    return ChangeNotifierProvider(
      create: (context) => ModelPageHome(),
      child: Consumer<ModelPageHome>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titleAppBar(model.selectedIndex)),
            ),
            drawer: const WidgetDrawer(),
            body: model.widgetPage(),
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
    final localeApp = AppLocalizations.of(context)!;
    final provider = Provider.of<ModelPageHome>(context);
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Center(child: Text(localeApp.navigation)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: Text(localeApp.finance),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: Text(localeApp.lists),
            onTap: () {
              Navigator.pop(context);
              provider.onItemTapped(1);
            },
          ),
          Center(child: Text(localeApp.aboutTheApp)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.app_shortcut_outlined),
            title: Text(localeApp.version),
            subtitle: const Text('1.0.12'),
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: Text(localeApp.privacyPolicy),
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
            title: Text(localeApp.leaveAReview),
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
