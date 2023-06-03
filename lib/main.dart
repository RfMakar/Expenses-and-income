import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MaterialAppMain());
}

class MaterialAppMain extends StatelessWidget {
  const MaterialAppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', '')],
      theme: MyThemeApp.light(const Color.fromRGBO(130, 54, 140, 1)).themeLight,
      darkTheme:
          MyThemeApp.dark(const Color.fromRGBO(130, 54, 140, 1)).themeLight,
      themeMode: ThemeMode.light,
      home: const ScreenHome(),
    );
  }
}

class MyThemeApp {
  late ThemeData themeLight;
  late ThemeData themeDark;

  MyThemeApp.light(Color colorTheme) {
    themeLight = ThemeData(
      useMaterial3: true,

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
      appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: colorTheme),
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
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        fillColor: Colors.white,
        color: Colors.white,
        textStyle: TextStyle(fontSize: 16),
        //borderColor: Colors.white,
      ),

      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   foregroundColor: Colors.white,
      //   backgroundColor: colorTheme,
      // ),
    );
  }
  MyThemeApp.dark(Color colorTheme) {
    themeLight = ThemeData(
      useMaterial3: true,
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
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    );
  }
}
