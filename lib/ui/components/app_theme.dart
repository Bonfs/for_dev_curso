import 'package:flutter/material.dart';

const _primaryColor = Color.fromRGBO(126, 14, 79, 1);
const _primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
const _primaryColorLight = Color.fromRGBO(188, 71, 123, 1);

ThemeData appTheme() => ThemeData(
  primaryColor: _primaryColor,
  primaryColorDark: _primaryColorDark,
  primaryColorLight: _primaryColorLight,
  colorScheme: const ColorScheme(
    primary: _primaryColor,
    primaryVariant: _primaryColorDark,
    secondary: _primaryColorLight,
    secondaryVariant: _primaryColorDark,
    surface: Colors.white,
    background: Colors.white,
    error: Colors.redAccent,
    onPrimary: Color(0xff000000),
    onSecondary: Color(0xff000000),
    onSurface: Color(0xff000000),
    onBackground: Color(0xff000000),
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  backgroundColor: Colors.white,
  textTheme:  const TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: _primaryColorDark
    )
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: _primaryColorLight)
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: _primaryColor)
    ),
    alignLabelWithHint: true
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((_) => _primaryColor),
      overlayColor: MaterialStateProperty.resolveWith((_) => _primaryColorLight),
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
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith((_) => _primaryColorLight),
      foregroundColor: MaterialStateProperty.resolveWith((states) => _primaryColor),
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
);