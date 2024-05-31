import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Color(0xff6c7245),
    secondary: Color(0xffe09132),
      tertiary: Color(0xffa58e74),
    //fourth : Color(0xffffefcd),

  ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);



class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightMode;

  ThemeData get currentTheme => _currentTheme;

  set currentTheme(ThemeData themeData){
    _currentTheme = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_currentTheme == lightMode){
      currentTheme = darkMode;
    }else {
      currentTheme = lightMode;
    }
  }
}