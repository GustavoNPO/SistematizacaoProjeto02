import 'package:flutter/material.dart';


/*
Aqui da pra mudar as cores e o tema do app inteiro
Basta importar esse arquivo no main.dart e usar a variavel appTheme
*/
final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.green,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.grey[50],
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18.0),
    bodyMedium: TextStyle(fontSize: 16.0),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    labelLarge:
        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 14.0),
    unselectedLabelStyle: TextStyle(fontSize: 12.0),
    showUnselectedLabels: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      textStyle:
          TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    labelStyle: TextStyle(fontSize: 18.0),
  ),
);


