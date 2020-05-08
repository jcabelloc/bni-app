import 'package:bniapp/screens/view-referencia/view_referencia_screen.dart';
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/login/login_screen.dart';
import 'package:bniapp/screens/login/login_screen.dart';
import 'package:bniapp/screens/main/main_screen.dart';
import 'package:bniapp/screens/save_referencia/save_referencia_screen.dart';
import 'package:bniapp/screens/update_miembro/update_miembro_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() =>
    initializeDateFormatting('es_ES', null).then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        primaryColorDark: kPrimaryColorDark,
        primaryColorLight: kPrimaryColorLight,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: kPrimaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        MainScreen.id: (context) => MainScreen(),
        SaveReferenciaScreen.id: (context) => SaveReferenciaScreen(),
        UpdateMiembroScreen.id: (context) => UpdateMiembroScreen(),
        ViewReferenciaScreen.id: (context) => ViewReferenciaScreen(),
      },
    );
  }
}
