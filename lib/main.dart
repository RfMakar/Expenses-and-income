import 'package:flutter/material.dart';
import 'package:budget/model_main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialAppMain());
}

class MaterialAppMain extends StatelessWidget {
  const MaterialAppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelMaterialAppMain(),
      child: Consumer<ModelMaterialAppMain>(
        builder: (context, model, _) => FutureBuilder<bool>(
            future: model.getBoolDarckTheme(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return MaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('ru', '')],
                theme: MyThemeApp.light(const Color.fromRGBO(130, 54, 140, 1))
                    .themeLight,
                darkTheme:
                    MyThemeApp.dark(const Color.fromRGBO(130, 54, 140, 1))
                        .themeLight,
                themeMode: snapshot.data! ? ThemeMode.dark : ThemeMode.light,
                home: const HomeMain(),
              );
            }),
      ),
    );
  }
}

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelHomeMain(),
      child: Consumer<ModelHomeMain>(
        builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: Text(model.titleAppBar()),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Добавить',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Список',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ],
            currentIndex: model.selectedIndex,
            onTap: model.onItemTapped,
          ),
          body: model.getWidgetOptions(),
        ),
      ),
    );
  }
}

class MyThemeApp {
  late ThemeData themeLight;
  late ThemeData themeDark;

  MyThemeApp.light(Color colorTheme) {
    themeLight = ThemeData(
      colorScheme: const ColorScheme.light().copyWith(primary: colorTheme),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(colorTheme),
        checkColor: MaterialStateProperty.all(Colors.white),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      toggleButtonsTheme: const ToggleButtonsThemeData(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
  MyThemeApp.dark(Color colorTheme) {
    themeLight = ThemeData(
      colorScheme: const ColorScheme.dark().copyWith(primary: Colors.white),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colorTheme,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
        trackColor: MaterialStateProperty.all(Colors.grey),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(colorTheme),
        checkColor: MaterialStateProperty.all(Colors.white),
      ),
      appBarTheme: const AppBarTheme(centerTitle: true),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
      toggleButtonsTheme: const ToggleButtonsThemeData(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}
