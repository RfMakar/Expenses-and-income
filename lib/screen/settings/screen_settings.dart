import 'package:flutter/material.dart';
import 'package:budget/model_main.dart';
import 'package:budget/screen/settings/model_settings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        StyleApp(),
        DataApp(),
        InfoApp(),
      ],
    );
  }
}

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('О приложении')]),
        const ListTile(
          title: Text('Версия'),
          trailing: Text('1.0.5'),
          onTap: null,
        ),
        ListTile(
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
        ListTile(
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
        const Divider(),
      ],
    );
  }
}

class DataApp extends StatelessWidget {
  const DataApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelScreenSettings(),
      child: Consumer<ModelScreenSettings>(
        builder: (_, model, __) => Column(
          children: [
            const Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Text('Данные')]),
            ListTile(
              title: const Text('Хранение данных'),
              onTap: () => onTapListTileSaveData(context),
            ),
            ListTile(
              title: const Text('Удалить расходы'),
              onTap: () => onTapListTileDel(context, model.deleteAllExpenses),
            ),
            ListTile(
              title: const Text('Удалить доходы'),
              onTap: () => onTapListTileDel(context, model.deleteAllIncome),
            ),
            ListTile(
              title: const Text('Удалить все данные'),
              onTap: () => onTapListTileDel(context, model.deleteAllBD),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void onTapListTileSaveData(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: const [
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                    '''Все данные (расходы, доходы, списки) хранятся в телефоне локально, при удаление приложения они автоматически удалятся. При обновление приложения данные сохраняются'''),
              ),
            ],
          );
        });
  }

  void onTapListTileDel(BuildContext context, void Function() onTap) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Удалить?'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  onTap();
                  Navigator.pop(context);
                },
                child: const Text('Да'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Нет'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StyleApp extends StatelessWidget {
  const StyleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelMaterialAppMain>(
      builder: (context, model, _) => FutureBuilder<bool>(
          future: model.getBoolDarckTheme(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                children: const [CircularProgressIndicator()],
              );
            }

            return Column(
              children: [
                const Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Text('Оформление')]),
                SwitchListTile(
                  value: snapshot.data!,
                  title: const Text('Темная тема'),
                  onChanged: model.setBoolDarckTheme,
                ),
                const Divider(),
              ],
            );
          }),
    );
  }
}
