import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(126, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

    return MaterialApp(
      title: '4Dev Curso',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        accentColor: primaryColor,
        backgroundColor: Colors.white,
        textTheme:  const TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorDark
          )
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)
          ),
          alignLabelWithHint: true
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((_) => primaryColor),
            overlayColor: MaterialStateProperty.resolveWith((_) => primaryColorLight),
            padding: MaterialStateProperty.resolveWith((_) {
              return const EdgeInsets.symmetric(vertical: 10, horizontal: 20);
            }),
            // foregroundColor: MaterialStateProperty.resolveWith((states) => ButtonTextTheme.primary),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              );
            })
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((_) => primaryColorLight),
            foregroundColor: MaterialStateProperty.resolveWith((states) => primaryColor),
            padding: MaterialStateProperty.resolveWith((_) {
              return const EdgeInsets.symmetric(vertical: 10, horizontal: 20);
            }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              );
            })
          )
        ),
      ),
      home: LoginPage(),
    );
  }
}