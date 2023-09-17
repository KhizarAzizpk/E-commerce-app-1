import 'package:flutter/material.dart';

class EcommerceAppTheme {
  static ThemeData getAppTheme() {
    final Color primaryColor = Color.fromRGBO(35, 180, 185, 1);
    final Color accentColor = Colors.orangeAccent;

    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: primaryColor,
      accentColor: accentColor,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        color: primaryColor,
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          color: Colors.black54,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
surfaceTintColor: primaryColor,
        shadowColor: primaryColor,
        elevation: 0,
        // contentTextStyle: TextStyle(
        //   fontSize: 16.0,
        //   color: Colors.black,
        // ),
      ),
    );
  }
}
